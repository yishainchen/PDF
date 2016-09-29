//
//  CustomPrintPageRenderer.swift
//  Print2PDF
//
//  Created by B1media on 2016/9/29.
//  Copyright © 2016年 Appcoda. All rights reserved.
//

import UIKit

class CustomPrintPageRenderer: UIPrintPageRenderer {
    let A4PageWidth: CGFloat = 595.2
    
    let A4PageHeight: CGFloat = 841.8
    override init() {
        super.init()
        
        // Specify the frame of the A4 page.
        let pageFrame = CGRect(x: 0.0, y: 0.0, width: A4PageWidth, height: A4PageHeight)
        
        // Set the page frame.
        self.setValue(NSValue(CGRect: pageFrame), forKey: "paperRect")
        
        // Set the horizontal and vertical insets (that's optional).
        self.setValue(NSValue(CGRect: pageFrame), forKey: "printableRect")
        
//        self.setValue(NSValue(CGRect: CGRectInset(pageFrame, 10.0, 10.0)), forKey: "printableRect")
    }
    
    func exportHTMLContentToPDF(HTMLContent: String) {
        let printPageRenderer = CustomPrintPageRenderer()
        
        let printFormatter = UIMarkupTextPrintFormatter(markupText: HTMLContent)
        printPageRenderer.addPrintFormatter(printFormatter, startingAtPageAtIndex: 0)
        
        let pdfData = drawPDFUsingPrintPageRenderer(printPageRenderer)
        
        pdfFilename = "\(AppDelegate.getAppDelegate().getDocDir())/Invoice\(invoiceNumber).pdf"
        pdfData.writeToFile(pdfFilename, atomically: true)
        
        print(pdfFilename)
    }
    
    func drawPDFUsingPrintPageRenderer(printPageRenderer: UIPrintPageRenderer) -&gt; NSData! {
    let data = NSMutableData()
    
    UIGraphicsBeginPDFContextToData(data, CGRectZero, nil)
    
    UIGraphicsBeginPDFPage()
    
    printPageRenderer.drawPageAtIndex(0, inRect: UIGraphicsGetPDFContextBounds())
    
    UIGraphicsEndPDFContext()
    
    return data
    }

}
