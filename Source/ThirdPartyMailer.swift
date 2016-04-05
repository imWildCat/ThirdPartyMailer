//
// ThirdPartyMailer.swift
//
// Copyright (c) 2016 Vincent Tourraine (http://www.vtourraine.net)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import UIKit

/// Tests third party mail clients availability, and opens third party mail clients in compose mode.
public class ThirdPartyMailer {

    /**
     Tests the availability of a third-party mail client.

     - Parameters application: The main application (usually `UIApplication.sharedApplication()`).
     - Parameters client: The third-party client to test.

     - Returns: `true` if the application can open the client; otherwise, `false`.
     */
    public class func application(application: UIApplicationOpenURLProtocol, isMailClientAvailable client: ThirdPartyMailClient) -> Bool {
        let components = NSURLComponents()
        components.scheme = client.URLScheme

        guard let URL = components.URL
            else { return false }

        return application.canOpenURL(URL)
    }

    /**
     Opens a third-party mail client in compose mode.

     - Parameters application: The main application (usually `UIApplication.sharedApplication()`).
     - Parameters client: The third-party client to test.
     - Parameters recipient: The email address of the recipient (optional).
     - Parameters subject: The email subject (optional).
     - Parameters body: The email body (optional).

     - Returns: `true` if the application opens the client; otherwise, `false`.
     */
    public class func application(application: UIApplicationOpenURLProtocol, openMailClient client: ThirdPartyMailClient, recipient: String?, subject: String?, body: String?) -> Bool {
        return application.openURL(client.composeURL(recipient, subject: subject, body: body))
    }
}

/// Extension with URL-specific methods for `UIApplication`
public protocol UIApplicationOpenURLProtocol {
    func canOpenURL(url: NSURL) -> Bool
    func openURL(url: NSURL) -> Bool
}

extension UIApplication: UIApplicationOpenURLProtocol {}
