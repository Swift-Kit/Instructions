// MixedCoachMarksViewsViewController.swift
//
// Copyright (c) 2015 Frédéric Maquin <fred@ephread.com>
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
import Instructions

// This class mix different kind of coach marks together.
internal class MixedCoachMarksViewsViewController: ProfileViewController, CoachMarksControllerDataSource {
    //MARK: - IBOutlet
    @IBOutlet var answersLabel: UILabel?

    //MARK: - Private properties
    private let swipeImage = UIImage(named: "swipe")

    private let answersText = "That's the number of answers you gave."

    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.coachMarksController?.datasource = self

        self.coachMarksController?.overlayBackgroundColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.5)
    }

    //MARK: - Protocol Conformance | CoachMarksControllerDataSource
    func numberOfCoachMarksForCoachMarksController(coachMarksController: CoachMarksController) -> Int {
        return 5
    }

    func coachMarksController(coachMarksController: CoachMarksController, coachMarksForIndex index: Int) -> CoachMark {

        var coachMark : CoachMark

        switch(index) {
        case 0:
            coachMark = coachMarksController.coachMarkForView(self.handleLabel)
        case 1:
            coachMark = coachMarksController.coachMarkForView(self.emailLabel)
        case 2:
            coachMark = coachMarksController.coachMarkForView(self.postsLabel)
        case 3:
            coachMark = coachMarksController.coachMarkForView(self.answersLabel)
        case 4:
            coachMark = coachMarksController.coachMarkForView(self.reputationLabel)
        default:
            coachMark = coachMarksController.coachMarkForView()
        }

        coachMark.gapBetweenCoachMarkAndCutoutPath = 6.0

        return coachMark
    }

    func coachMarksController(coachMarksController: CoachMarksController, coachMarkViewsForIndex index: Int, coachMark: CoachMark) -> (bodyView: CoachMarkBodyView, arrowView: CoachMarkArrowView?) {

        var bodyView : CoachMarkBodyView
        var arrowView : CoachMarkArrowView?

        switch(index) {
        case 0:
            let coachMarkBodyView = CustomCoachMarkBodyView()
            var coachMarkArrowView: CustomCoachMarkArrowView? = nil

            coachMarkBodyView.hintLabel.text = self.handleText
            coachMarkBodyView.nextButton.setTitle(self.nextButtonText, forState: .Normal)

            var width: CGFloat = 0.0

            if let handleLabel = self.handleLabel {
                width = handleLabel.bounds.width
            }

            if let arrowOrientation = coachMark.arrowOrientation {
                coachMarkArrowView = CustomCoachMarkArrowView(orientation: arrowOrientation)

                coachMarkArrowView!.plate.addConstraint(NSLayoutConstraint(item: coachMarkArrowView!.plate, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: width))
            }

            bodyView = coachMarkBodyView
            arrowView = coachMarkArrowView
        case 1:
            let coachViews = coachMarksController.defaultCoachViewsWithArrow(true, arrowOrientation: coachMark.arrowOrientation)

            coachViews.bodyView.hintLabel.text = self.emailText
            coachViews.bodyView.nextLabel.text = self.nextButtonText

            bodyView = coachViews.bodyView
            arrowView = coachViews.arrowView
        case 2:
            let coachViews = coachMarksController.defaultCoachViewsWithArrow(true, arrowOrientation: coachMark.arrowOrientation)

            coachViews.bodyView.hintLabel.text = self.postsText
            coachViews.bodyView.nextLabel.text = self.nextButtonText

            bodyView = coachViews.bodyView
            arrowView = coachViews.arrowView
        case 3:
            let coachViews = coachMarksController.defaultCoachViewsWithArrow(true, arrowOrientation: coachMark.arrowOrientation)

            coachViews.bodyView.hintLabel.text = self.answersText
            coachViews.bodyView.nextLabel.text = self.nextButtonText

            bodyView = coachViews.bodyView
            arrowView = coachViews.arrowView
        case 4:
            let coachMarkBodyView = TransparentCoachMarkBodyView()
            var coachMarkArrowView: TransparentCoachMarkArrowView? = nil

            coachMarkBodyView.hintLabel.text = self.handleText

            if let arrowOrientation = coachMark.arrowOrientation {
                coachMarkArrowView = TransparentCoachMarkArrowView(orientation: arrowOrientation)
            }

            bodyView = coachMarkBodyView
            arrowView = coachMarkArrowView
        default:
            let coachViews = coachMarksController.defaultCoachViewsWithArrow(true, arrowOrientation: coachMark.arrowOrientation)
            
            bodyView = coachViews.bodyView
            arrowView = coachViews.arrowView
        }
        
        return (bodyView: bodyView, arrowView: arrowView)
    }
}