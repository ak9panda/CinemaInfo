//
//  AppDelegate.swift
//  CinemaInfo
//
//  Created by admin on 15/02/2021.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //Inject persistent container for now
        CoreDataStack.shared.persistantContainer = self.persistentContainer
        
        print("Documents Directory: ", FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last ?? "Not Found!")
        
        // movie list view controller
        let movieListVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: MovieListViewController.self)) as! UINavigationController
        
        let bookmarkMoviesVC = BookmarkMoviesRouter.createVC()
        let settingsVC = SettingRouter.createVC()
        let tabBarController = UITabBarController()
        tabBarController.hidesBottomBarWhenPushed = true
        tabBarController.setViewControllers([
            movieListVC,
            bookmarkMoviesVC,
            settingsVC
        ], animated: true)

        tabBarController.tabBar.barTintColor = UIColor.init(named: Colors.primaryBackground.rawValue)
        tabBarController.tabBar.tintColor = UIColor(named: Colors.primary.rawValue)
        tabBarController.tabBar.items![0].title = "Discover"
        tabBarController.tabBar.items![0].image = #imageLiteral(resourceName: "earth_empty")
        tabBarController.tabBar.items![0].selectedImage = #imageLiteral(resourceName: "earth_fill")
        tabBarController.tabBar.items![1].title = "Bookmark"
        tabBarController.tabBar.items![1].image = #imageLiteral(resourceName: "bookmark_empty")
        tabBarController.tabBar.items![1].selectedImage = #imageLiteral(resourceName: "bookmark_filled")
        tabBarController.tabBar.items![2].title = "Settings"
        tabBarController.tabBar.items![2].image = #imageLiteral(resourceName: "settings_empty")
        tabBarController.tabBar.items![2].selectedImage = #imageLiteral(resourceName: "settings_fill")
        
        window?.rootViewController = tabBarController
        UIApplication.shared.override(UserDefaults.standard.overridedUserInterfaceStyle)
        window?.makeKeyAndVisible()
        
        return true
    }
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "CinemaInfo")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

