//
//  UserPersistance.swift
//  VGCatalogue
//
//  Created by Aleksandar Micevski on 28.2.22.
//

import Foundation

class UserPersistance {
    static let sharedInstance = UserPersistance()
    
    func setuserLoggedIn(loggedIn: Bool) {
        UserDefaults.standard.set(loggedIn, forKey: "isLoggedIn")
    }
    
    func getUserIsLoggedIn() -> Bool {
        return UserDefaults.standard.bool(forKey: "isLoggedIn")  
    }
    
    func setAccessToken(token: String) {
        UserDefaults.standard.set(token, forKey: "accessToken")
    }
    
    func getAccessToken() -> String? {
        return UserDefaults.standard.string(forKey: "accessToken") ?? ""
    }
    
    func setCrmInfo(crmInfo: CrmInfo) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(crmInfo)
            UserDefaults.standard.set(data, forKey: "crmInfo")
        } catch {
            print("Unable to Encode crmInfo (\(error))")
        }
    }
    
    func getCrmInfo() -> CrmInfo? {
        var crmInfo: CrmInfo? = nil
        
        if let data = UserDefaults.standard.data(forKey: "erpInfo") {
            do {
                let decoder = JSONDecoder()
                crmInfo = try decoder.decode(CrmInfo.self, from: data)
            } catch {
                print("Unable to Decode crmInfo (\(error))")
            }
        }
        
        return crmInfo
    }
    
    func setUserInfo(userInfo: UserInfo) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(userInfo)
            UserDefaults.standard.set(data, forKey: "userInfo")
        } catch {
            print("Unable to Encode userInfo (\(error))")
        }
    }
    
    func getUserInfo() -> UserInfo? {
        var userInfo: UserInfo? = nil
        
        if let data = UserDefaults.standard.data(forKey: "userInfo") {
            do {
                let decoder = JSONDecoder()
                userInfo = try decoder.decode(UserInfo.self, from: data)
            } catch {
                print("Unable to Decode userInfo (\(error)")
            }
        }
        
        return userInfo
    }
    
    func setEmployee(employee: Employee) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(employee)
            UserDefaults.standard.set(data, forKey: "employee")
        } catch {
            print("Unable to Encode employee (\(error)")
        }
    }
    
    func getEmployee() -> Employee? {
        var emplyee: Employee? = nil
        if let data = UserDefaults.standard.data(forKey: "employee") {
            do {
                let decoder = JSONDecoder()
                emplyee = try decoder.decode(Employee.self, from: data)
            } catch {
                print("Unable to Decode employee (\(error)")
            }
        }
        return emplyee
    }
    
    
    func setErpInfo(erpInfo: ErpInfo) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(erpInfo)
            UserDefaults.standard.set(data, forKey: "erpInfo")
        } catch {
            print("Unable to Encode erpInfo (\(error))")
        }
    }
    
    func getErpInfo() -> ErpInfo? {
        var erpInfo: ErpInfo? = nil
        
        if let data = UserDefaults.standard.data(forKey: "erpInfo") {
            do {
                let decoder = JSONDecoder()
                erpInfo = try decoder.decode(ErpInfo.self, from: data)
            } catch {
                print("Unable to Decode erpInfo (\(error))")
            }
        }
        
        return erpInfo
    }
}
