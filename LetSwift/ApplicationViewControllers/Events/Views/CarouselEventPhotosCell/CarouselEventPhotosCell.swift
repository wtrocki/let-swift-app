//
//  CarouselEventPhotosCell.swift
//  LetSwift
//
//  Created by Kinga Wilczek on 09.05.2017.
//  Copyright © 2017 Droids On Roids. All rights reserved.
//

import UIKit

final class CarouselEventPhotosCell: UITableViewCell {

    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var pageControl: UIPageControl!

    fileprivate var lastContentOffset: CGFloat = 0.0
    
    private let disposeBag = DisposeBag()

    var viewModel: CarouselEventPhotosCellViewModel! {
        didSet {
            if viewModel != nil {
                reactiveSetup()
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        scrollView.delegate = self
    }

    private func reactiveSetup() {
        viewModel.photosObservable.subscribeNext(startsWithInitialValue: true) { [weak self] photos in
            DispatchQueue.main.async {
                self?.setupScrollView(with: photos)
                self?.pageControl.numberOfPages = photos.count
                self?.pageControl.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            }
        }
        .add(to: disposeBag)

        viewModel.currentPageObservable.subscribeNext { [weak self] page in
            self?.pageControl.currentPage = page
        }
        .add(to: disposeBag)
    }

    private func setupScrollView(with images: [Photo]) {
        let frameSize = scrollView.frame.size

        images.enumerated().forEach { index, card in
            let frame = CGRect(origin: CGPoint(x: frameSize.width * CGFloat(index), y: 0.0),
                               size: frameSize)

            let subview = UIImageView(frame: frame)
            subview.contentMode = .scaleAspectFill
            subview.clipsToBounds = true
            subview.sd_setImage(with: images[index].big)

            scrollView.addSubview(subview)
        }

        scrollView.contentSize = CGSize(width: frameSize.width * CGFloat(images.count),
                                        height: frameSize.height)
    }
}

extension CarouselEventPhotosCell: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        viewModel.scrollViewSwipeDidFinishObservable.next(Int(scrollView.contentOffset.x / scrollView.frame.width))
    }
}
