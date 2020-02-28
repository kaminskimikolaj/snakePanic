//
//  HtmlParsing.swift
//  sip2po
//
//  Created by Mikołaj Kamiński on 21/09/2019.
//  Copyright © 2019 Mikołaj Kamiński. All rights reserved.
//

import SwiftSoup

class HtmlScrapper {
    
    struct SchedulePattern {
        static let proxy = "zastępstwo"
        static let released = "zajęcia odwołane"
    }
    
    enum StringMode {
        case groupName
        case teacherName
        case roomName
    }
    func parseLessonsSchedule(html: String) throws -> ScheduleWeek {
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        func processString(input: [TextNode]) throws -> ScheduleLesson {
            let lesson = ScheduleLesson(context: context)
            for (nodeIndex, node) in input.enumerated() {
                switch nodeIndex {
                case 0:
                    var name = node.description
                    if node.description.contains(SchedulePattern.proxy) {
                        (lesson.proxy, lesson.released) = (true, false)
                        name = String(node.description.prefix(name.count - SchedulePattern.proxy.count - 3))
                    } else if node.description.contains(SchedulePattern.released) {
                        (lesson.proxy, lesson.released) = (false, true)
                        name = String(node.description.prefix(name.count - SchedulePattern.released.count - 3))
                    } else { (lesson.proxy, lesson.released) = (false, false) }
                    lesson.lessonName = name
                case 1:
                    let timing = node.description.dropLast()
                    
                    var start = String(timing[timing.startIndex...timing.index(timing.startIndex, offsetBy: 4)])
                    if start.first == "0" {
                        start.removeFirst()
                    }
//                    print(start)
                    lesson.start = start
                    
                    var end = String(timing[timing.index(timing.endIndex, offsetBy: -5)..<timing.endIndex])
                    if end.first == "0" {
                        end.removeFirst()
                    }
//                    print(end)
                    lesson.end = end
                case 2:
                    var buffer = [Character]()
                    var mode = StringMode.groupName
                    for char in Array(node.description) {
                        switch char {
                        case ",", ")":
                            switch mode {
                            case .groupName:
                                lesson.groupName = String(buffer)
                                mode = .teacherName
                                break
                            case .teacherName:
                                lesson.teacherName = String(buffer)
                                mode = .roomName
                                break
                            case .roomName:
                                lesson.roomName = String(buffer)
                                break
                            }
                            buffer.removeAll()
                        case "(": break
                        case " ": if buffer.count == 0 { break } else { buffer.append(char) }
                        default: buffer.append(char)
                        }
                    }
                default: throw HttpsScrapper.NetworkError.unknownStringPattern(content: node.description) }
            }
            return lesson
        }
        do {
            let doc: Document = try SwiftSoup.parse(html)
            let rows: Elements = try doc.select("#section > table > tbody > tr")
            var days = [ScheduleDay]()
            for number in 0...4 {
                let day = ScheduleDay(context: context)
                day.dayNumber = Int16(number)
                days.append(day)
            }
            for (rowIndex, row) in rows.array()[2...23].enumerated() where rowIndex % 2 == 0 {
                let cells = try row.select("> td")
                for (cellIndex, cell) in cells.enumerated() where cellIndex != 0 {
                    if try cell.text().count > 0 {
                        let nodes = try cell.select("table > tbody > tr > td").array()[0].textNodes()
                        do {
                            let lesson = try processString(input: nodes)
                            lesson.lessonNumber = Int16(rowIndex / 2)
                            days[cellIndex - 1].addToLesson(lesson)
//                            print("rowIndex: \(rowIndex), cellIndex: \(cellIndex), \(lesson)")
                        } catch let error { throw error }
                    }
                }
            }
            let week = ScheduleWeek(context: context)
            for day in days {
                week.addToDay(day)
            }
            return week
        } catch {
            throw HttpsScrapper.NetworkError.htmlParsing
        }
    }
}
