//
//  SignalingViewController.swift
//  WebRtcDemoApp
//
//  Created by Priya Chaurasiya on 16/03/24.
//

import UIKit
import Starscream

class SignalingViewController: UIViewController, WebSocketDelegate {
    
    func didReceive(event: Starscream.WebSocketEvent, client: Starscream.WebSocketClient) {
        print("Received message: \(Starscream.WebSocketClient.self)")
    }
    
    var socket: WebSocket!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Establish WebSocket connection to signaling server
        let urlString = "ws://8080"
        socket = WebSocket(request: URLRequest(url: URL(string: urlString)!))
        socket.delegate = self
        socket.connect()
    }

    // MARK: - WebSocketDelegate methods

    func websocketDidConnect(socket: WebSocketClient) {
        print("WebSocket connected")
    }

    func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
        print("WebSocket disconnected: \(error?.localizedDescription ?? "unknown error")")
    }

    func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
        print("Received message: \(text)")
        // Handle incoming signaling message (offer, answer, ICE candidate, etc.)
        // You'll need to parse the incoming message and take appropriate actions
    }

    func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        print("Received data: \(data)")
        // Handle incoming binary data if needed
    }

    // MARK: - Signaling methods

    func sendSignalingMessage(message: String) {
        // Send signaling message to signaling server
        socket.write(string: message)
    }

    // Example methods for initiating call, sending SDP offer, and ICE candidate

    func initiateCall() {
        // Example: Send a message to initiate a call
        let message = "initiate_call"
        sendSignalingMessage(message: message)
    }

    func sendSDPOffer(offer: String) {
        // Example: Send SDP offer to signaling server
        let message = "{\"type\": \"offer\", \"sdp\": \"\(offer)\"}"
        sendSignalingMessage(message: message)
    }

    func sendICECandidate(candidate: String) {
        // Example: Send ICE candidate to signaling server
        let message = "{\"type\": \"candidate\", \"candidate\": \"\(candidate)\"}"
        sendSignalingMessage(message: message)
    }
}
