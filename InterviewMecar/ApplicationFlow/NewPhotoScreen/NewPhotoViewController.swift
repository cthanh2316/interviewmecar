//
//  AddPhotoViewController.swift
//  InterviewMecar
//
//  Created by Cong Thanh on 3/19/21.
//

import UIKit
import Nuke
import SwiftyJSON

class NewPhotoViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var cstHeightForContentView: NSLayoutConstraint!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblWhatsNew: UILabel!
    @IBOutlet weak var imvNewPhoto: UIImageView!
    @IBOutlet weak var cstHeightImvNewPhoto: NSLayoutConstraint!
    @IBOutlet weak var imvAvatarAuthor: UIImageView!
    @IBOutlet weak var lblAuthorName: UILabel!
    @IBOutlet weak var lblAuthorSigned: UILabel!
    @IBOutlet weak var vwBrowseAll: UIView!
    @IBOutlet weak var lblBrowseAll: UILabel!
    @IBOutlet weak var leftClvPhotos: UICollectionView!
    @IBOutlet weak var rightClvPhotos: UICollectionView!
    @IBOutlet weak var btnSeeMore: UIButton!
    @IBOutlet weak var cstBottomScrollview: NSLayoutConstraint!
    
    var photos: [PhotoModel] = []
    
    var leftPhotos: [PhotoModel] = []
    
    var rightPhotos: [PhotoModel] = []
    
    let cellWidth = (ScreenSize.WIDTH - 32 - 9)/2 // 32: Leading - Trailing, 9: spacing, 2: 2 line vertical
    
    let lineSpacing: CGFloat = 9.0
    
    let loadMoreViewHeight: CGFloat = 52 + 32
    
    var currentPage: Int = 0 {
        didSet {
            createTempData(page: currentPage)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        loadNewImage()
        createTempData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    private func createTempData(page: Int = 0) {
        let dict = Utils.parseJsonFromFile(filename: "Photos")
        for (_, photoData): (String, JSON) in dict["data"] {
            let photo = PhotoModel(data: photoData)
            photos.append(photo)
            let leftClvContentHeight = calculateContentSizeHeight(collectionView: leftClvPhotos, photos: leftPhotos)
            let rightClvContentHeight = calculateContentSizeHeight(collectionView: rightClvPhotos, photos: rightPhotos)
            if leftClvContentHeight < rightClvContentHeight {
                leftPhotos.append(photo)
            } else {
                rightPhotos.append(photo)
            }
        }
        let leftClvContentSize = calculateContentSizeHeight(collectionView: leftClvPhotos, photos: leftPhotos)
        let rightClvContentSize = calculateContentSizeHeight(collectionView: rightClvPhotos, photos: rightPhotos)
        cstHeightForContentView.constant = vwBrowseAll.frame.origin.y + (self.tabbar?.bounds.size.height ?? 0.0) + self.topbarHeight + loadMoreViewHeight + max(leftClvContentSize, rightClvContentSize)
        self.view.layoutIfNeeded()
        leftClvPhotos.reloadData()
        rightClvPhotos.reloadData()
    }
    
    private func calculateContentSizeHeight(collectionView: UICollectionView, photos: [PhotoModel]) -> CGFloat {
        var height:CGFloat = 0.0
        for photo in photos {
            height += cellWidth * CGFloat(photo.height)/CGFloat(photo.width) + lineSpacing
        }
        return height
    }
    
    private func configureView() {
        cstBottomScrollview.constant = self.tabbar?.bounds.size.height ?? 0.0
        scrollView.delaysContentTouches = false
        leftClvPhotos.delegate = self
        leftClvPhotos.dataSource = self
        leftClvPhotos.register(UINib(nibName: CollectionViewCellName.photo, bundle: nil), forCellWithReuseIdentifier: CollectionViewCellName.photo)
        
        rightClvPhotos.delegate = self
        rightClvPhotos.dataSource = self
        rightClvPhotos.register(UINib(nibName: CollectionViewCellName.photo, bundle: nil), forCellWithReuseIdentifier: CollectionViewCellName.photo)
        
        lblTitle.text = "Discover".localized()
        lblTitle.font = UIFont.titleFont
        lblTitle.addCharacterSpacing(kernValue: .kernTitleValue)
        
        lblAuthorName.font = .lblName
        lblAuthorName.textColor = .lblNameColor
        lblAuthorSigned.font = .lblSubName
        lblAuthorSigned.textColor = .lblSubnameColor
        
        lblWhatsNew.text = "What's new today".localized().uppercased()
        lblWhatsNew.font = UIFont.sectionTitleFont
        lblWhatsNew.addCharacterSpacing(kernValue: .kernTitleValue)
        
        lblBrowseAll.text = "Browse all".localized().uppercased()
        lblBrowseAll.font = UIFont.sectionTitleFont
        lblBrowseAll.addCharacterSpacing(kernValue: .kernTitleValue)
        
        btnSeeMore.setTitle("See more".localized().uppercased(), for: .normal)
        btnSeeMore.titleLabel?.font = UIFont.btnTitleFont
        btnSeeMore.titleLabel?.addCharacterSpacing(kernValue: .kernBtnValue)
        btnSeeMore.setTitleColor(.lightBtnTextColor, for: .normal)
        btnSeeMore.borderWidth = .borderWidth
        btnSeeMore.borderColor = .borderColor
    }
    
    private func loadNewImage() {
        // Data test
        let newPhoto = PhotoModel(width: 512, height: 512, url: "https://homepages.cae.wisc.edu/~ece533/images/airplane.png")
        
        self.loadPhoto(from: newPhoto, to: self.imvNewPhoto)
        self.cstHeightImvNewPhoto.constant = CGFloat(newPhoto.height/newPhoto.width) * imvNewPhoto.bounds.size.width
        self.view.layoutIfNeeded()
        cstHeightForContentView.constant = vwBrowseAll.frame.origin.y + (self.tabbar?.bounds.size.height ?? 0.0) + self.topbarHeight + loadMoreViewHeight
    }
    @IBAction func onActionSeeMore(_ sender: Any) {
        currentPage += 1
    }
    
    private func loadPhoto(from photo: PhotoModel, to imageView: UIImageView) {
        if let url = URL(string: photo.url) {
            
            let request = Nuke.ImageRequest(url: url)
            
            let options = ImageLoadingOptions(
                placeholder: UIImage.placeholderImage,
                transition: .fadeIn(duration: 0.33)
                
            )
            Nuke.loadImage(with: request, options: options, into: imageView)
        }
    }

}

extension NewPhotoViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == leftClvPhotos {
            return leftPhotos.count
        } else { // Right Clv
            return rightPhotos.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellName.photo, for: indexPath) as? PhotoCollectionViewCell else {
            return UICollectionViewCell()
        }
        if collectionView == leftClvPhotos {
            self.loadPhoto(from: leftPhotos[indexPath.item], to: cell.imvPhoto)
        } else { // Right Clv
            self.loadPhoto(from: rightPhotos[indexPath.item], to: cell.imvPhoto)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == leftClvPhotos {
            let photo = leftPhotos[indexPath.item]
            return CGSize(width: cellWidth, height: cellWidth * CGFloat(photo.height)/CGFloat(photo.width))
        } else { // Right clv
            let photo = rightPhotos[indexPath.item]
            return CGSize(width: cellWidth, height: cellWidth * CGFloat(photo.height)/CGFloat(photo.width))
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return lineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
}


