//
//  InvoiceComposer.swift
//  Print2PDF
//
//  Created by yishain chen on 2016/9/28.
//  Copyright © 2016年 Appcoda. All rights reserved.
//

import UIKit


class InvoiceComposer: NSObject {
    
    let pathToInvoiceHTMLTemplate = NSBundle.mainBundle().pathForResource("invoice", ofType: "html")
    
    let pathToSingleItemHTMLTemplate = NSBundle.mainBundle().pathForResource("single_item", ofType: "html")
    
    let pathToLastItemHTMLTemplate = NSBundle.mainBundle().pathForResource("last_item", ofType: "html")
    
    let senderInfo = "Gabriel Theodoropoulos<br>123 Somewhere Str.<br>10000 - MyCity<br>MyCountry"
    
    let dueDate = ""
    
    let paymentMethod = "Wire Transfer"
    
    let logoImageURL = "http://www.appcoda.com/wp-content/uploads/2015/12/blog-logo-dark-400.png"
    
    var invoiceNumber: String!
    
    var pdfFilename: String!
    override init() {
        super.init()
    }
    
    func renderInvoice(invoiceNumber: String, invoiceDate: String, recipientInfo: String, items: [[String: String]], totalAmount: String) -> String! {
        // Store the invoice number for future use.
        self.invoiceNumber = invoiceNumber
        
        do {
            // Load the invoice HTML template code into a String variable.
            var HTMLContent = try String(contentsOfFile: pathToInvoiceHTMLTemplate!)
            
            // Replace all the placeholders with real values except for the items.
            // The logo image.
            HTMLContent = HTMLContent.stringByReplacingOccurrencesOfString("#LOGO_IMAGE#", withString: logoImageURL)
            
            // Invoice number.
            HTMLContent = HTMLContent.stringByReplacingOccurrencesOfString("#INVOICE_NUMBER#", withString: invoiceNumber)
            
            // Invoice date.
            HTMLContent = HTMLContent.stringByReplacingOccurrencesOfString("#INVOICE_DATE#", withString: invoiceDate)
            
            // Due date (we leave it blank by default).
            HTMLContent = HTMLContent.stringByReplacingOccurrencesOfString("#DUE_DATE#", withString: dueDate)
            
            // Sender info.
            HTMLContent = HTMLContent.stringByReplacingOccurrencesOfString("#SENDER_INFO#", withString: senderInfo)
            
            // Recipient info.
            HTMLContent = HTMLContent.stringByReplacingOccurrencesOfString("#RECIPIENT_INFO#", withString: recipientInfo.stringByReplacingOccurrencesOfString("\n", withString: "<br>"))
            
            // Payment method.
            HTMLContent = HTMLContent.stringByReplacingOccurrencesOfString("#PAYMENT_METHOD#", withString: paymentMethod)
            
            // Total amount.
            HTMLContent = HTMLContent.stringByReplacingOccurrencesOfString("#TOTAL_AMOUNT#", withString: totalAmount)
            
        }
        catch {
            print("Unable to open and use HTML template files.")
        }
        
        return nil
    }

    
}