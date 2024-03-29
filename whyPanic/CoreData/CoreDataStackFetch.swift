//
//  CoreDataStackFetch.swift
//  sip2po
//
//  Created by Mikołaj Kamiński on 27/09/2019.
//  Copyright © 2019 Mikołaj Kamiński. All rights reserved.
//

import CoreData

extension CoreDataStack {
    
    enum CoreDataError: Error {
        case fetchingError
    }
    
    func fetchWeeks() -> [ScheduleWeek]? {
        let fetchtRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ScheduleWeek")
        var weeks: [ScheduleWeek]?
        do {
            weeks = try CoreDataStack.sharedInstance.persistentContainer.viewContext.fetch(fetchtRequest) as? [ScheduleWeek]
        } catch let error {
            print(error)
        }
        return weeks
    }
    
//    func avaibleDates() -> [Date] {
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ScheduleWeek")
//        var dates = [Date]()
//        do {
//            let weeks = try CoreDataStack.sharedInstance.persistentContainer.viewContext.fetch(fetchRequest) as? [ScheduleWeek]
//            if weeks != nil {
//                for week in weeks! {
//                    if week.startDate != nil {
//                        dates.append(week.startDate!)
//                    }
//                }
//            }
//        }
//        catch let error { print(error) }
//        return dates
//    }
//
//
//    func weekForDate(date: Date) {
//        let fetchtRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ScheduleWeek")
//        var week: [ScheduleWeek]
//        fetchtRequest.predicate = NSPredicate(format: "startDate == %@", date as NSDate)
//        do {
//            week = try (persistentContainer.viewContext.fetch(fetchtRequest) as? [ScheduleWeek])!
//
//        } catch let error {
//            print(error)
//        }
////        return week
//    }
//    func lessonsForDay(dayNumber: Int) throws -> [ScheduleLesson] {
//        let fetchtRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ScheduleWeek")
//        fetchtRequest.returnsObjectsAsFaults = true
////        fetchtRequest.predicate
//        do {
//            let week = try castToScheduelDayArray(data: try persistentContainer.viewContext.fetch(fetchtRequest))
//            guard let days = week.first?.day?.allObjects else { throw CoreDataError.fetchingError }
//            var lessons = [ScheduleLesson]()
//            for day in days {
//                if let scheduleDay = day as? ScheduleDay {
//                    if scheduleDay.dayNumber == dayNumber {
//                        guard let safe = scheduleDay.lesson?.allObjects as? [ScheduleLesson] else { throw CoreDataError.fetchingError }
//                        lessons = safe
//                    }
//                }
//            }
//            return lessons
//        } catch {
//            throw CoreDataError.fetchingError
//        }
//    }
//
//    func castToScheduelDayArray(data: [Any]) throws -> [ScheduleWeek] {
//        if let output = data as? [ScheduleWeek] {
//            return output
//        } else {
//            throw CoreDataError.fetchingError
//        }
//    }
//
//
//    func remove() {
//        let context = self.persistentContainer.viewContext
//        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "ScheduleWeek")
//        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
//        do {
//           try context.execute(deleteRequest)
//            try self.saveContext()
//       } catch {
//           print ("There was an error")
//       }
//    }
//    func returnLessons(day: ScheduleDay) -> [[String]] {
//        var lessons = day.lesson!.allObjects
//        lessons.sort(by: {( ($0 as! ScheduleLesson).lessonNumber < ($1 as! ScheduleLesson).lessonNumber) })
//        var lessonsArray: [[String]] = []
//        for lesson in lessons {
//            if let lesson = lesson as? ScheduleLesson {
//                let data = [String(lesson.lessonNumber), lesson.lessonName!, lesson.teacherName!, lesson.roomName!]
//                lessonsArray.append(data)
//            }
//        }
//        return lessonsArray
//    }
    
//    func start() {
//        let stack = CoreDataStack()
//        let week = stack.fetchWeek()
//        var days = week?.first??.day?.allObjects
//        days!.sort(by: { ($0 as! ScheduleDay).dayNumber < ($1 as! ScheduleDay).dayNumber })
//        var weekArray: [[[String]]] = []
//        for case let day as ScheduleDay in days! {
//            print(day.dayNumber)
//            weekArray.append(returnLessons(day: day))
//        }
//        print(weekArray)
//    }
//    func lessonsForDayPredicate(dayNumber: Int) throws -> [ScheduleLesson] {
//        var fetchedResultsController: NSFetchedResultsController<Commit>!
//        let fetchtRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ScheduleDay")
//        fetchtRequest.returnsObjectsAsFaults = false
//        fetchtRequest.predicate = NSPredicate(format: "dayNumber == %@", String(dayNumber))
//        let week = try? persistentContainer.viewContext.fetch(fetchtRequest) as? [ScheduleDay]
//        guard var lessons = week?.first?.lesson?.allObjects as? [ScheduleLesson] else { throw CoreDataError.fetchingError }
//        lessons.sort(by: {( $0.lessonNumber < $1.lessonNumber )})
//        return lessons
//    }
}

//public class Commit: NSManagedObject {
//    override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
//        super.init(entity: entity, insertInto: context)
//        print("Init called!")
//    }
//}
