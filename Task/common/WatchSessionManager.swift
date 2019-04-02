//
//  WatchSessionManager.swift
//  Task
//
//  Created by Habib on 2/4/19.
//  Copyright © 2019 Habib. All rights reserved.
//

import WatchKit
import WatchConnectivity

typealias MessageReceived = (session: WCSession, message: [String: Any], replyHandler: (([String: Any]) -> Void)?)

//MARK: - protocol for manage all WatchOS delegations
protocol WatchOSDelegate: AnyObject {
    func messageReceived(tuple: MessageReceived)
}

//MARK: - protocol for manage all iOS delegations
protocol iOSDelegate: AnyObject {
    func messageReceived(tuple: MessageReceived)
}

class WatchSessionManger: NSObject {
    static let shared = WatchSessionManger()
    
    private override init() {}
    //MARK: - delegate for each platforms
    weak var watchOSDelegate: WatchOSDelegate?
    weak var iOSDelegate: iOSDelegate?
    
    private let session = WCSession.isSupported() ? WCSession.default : nil
    
    //if device is availabe
    var validSession: WCSession? {
        //isPaired - user has to have paired their device watch
        //isWatchAooInstalled - user must have installed watchApp
        #if os(iOS)
        if let session = session, session.isPaired, session.isWatchAppInstalled {
            return session
        }
        return nil
        #elseif os(watchOS)
        return session
        #endif
    }
    
    func startSession() {
        session?.delegate = self
        session?.activate()
    }
}

//MARK: - WCSessionDelegate
extension WatchSessionManger: WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("activationDidCompleteWith activationState:\(activationState) error:\(String(describing: error))")
    }
    
    //Only for iOS
    #if os(iOS)
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("sessionDidBecomeInactive: \(session)")
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        print("sessionDidDeactive: \(session)")
        /**
         * This is to re-activate the session on the phone when the user has switched from one
         * paired watch to second paired one. Calling it like this assumes that you have no other
         * threads/part of your code that needs to be given time before the switch occurs.
         */
        self.session?.activate()
    }
    #endif
    
}

//MARK: - Interactive Messaging
extension WatchSessionManger {
    private var validReachableSession: WCSession? {
        if let session = validSession, session.isReachable {
            return session
        }
        return nil
    }
    
    // Sender
    func sendMessage(message: [String: Any], replyHandler: (([String: Any]) -> Void)? = nil, errorHandler: ((Error) -> Void)? = nil) {
        validReachableSession?.sendMessage(message, replyHandler: replyHandler, errorHandler: errorHandler)
    }
    
    func sendMessage(data: Data, replyHandler: ((Data) -> Void)? = nil, errorHandler: ((Error) -> Void)? = nil) {
        validReachableSession?.sendMessageData(data, replyHandler: replyHandler, errorHandler: errorHandler)
    }
    //End Sender
    
    //Receiver
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        print("didReceiveMessage")
        handleSession(session: session, didReceivedMessage: message)
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        print("didReceiveMessage")
        handleSession(session: session, didReceivedMessage: message, replyHandler: replyHandler)
    }
    // End Receiver
    
    //Session Helper
    private func handleSession(session: WCSession, didReceivedMessage message: [String: Any], replyHandler: (([String: Any]) -> Void)? = nil) {
        #if os(iOS)
        iOSDelegate?.messageReceived(tuple: (session, message, replyHandler))
        #elseif os(watchOS)
        watchOSDelegate?.messageReceived(tuple: (session, message, replyHandler))
        #endif
    }
}
