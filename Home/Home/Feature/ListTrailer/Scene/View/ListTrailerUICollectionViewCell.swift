import Declayout
import YoutubeKit
import Components

final class ListTrailerUICollectionViewCell: UICollectionViewCell {
    
    private lazy var container = UIView.make {
        $0.backgroundColor = .clear
        $0.edges(to: contentView)
    }
    
    private var player: YTSwiftyPlayer!
    private let youtubeAPI = YoutubeAPI.shared
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setContent(with data: ListTrailerResponse.Result) {
        configurePlayer(with: data.key ?? "")
    }
    
    private func configurePlayer(with key: String) {
        player = YTSwiftyPlayer(
            frame: CGRect(x: 0, y: 0, width: ScreenSize.width, height: ScreenSize.height * 0.3),
            playerVars: [
                .playsInline(false),
                .videoID(key),
                .loopVideo(false),
                .showRelatedVideo(false),
                .autoplay(false)
            ]
        )
      
        player.delegate = self
        player.loadDefaultPlayer()
        subViews()
    }
    
    private func subViews() {
        player.edges(to: container)
        contentView.addSubviews([
            container.addSubviews([
                player
            ])
        ])
    }
}

extension ListTrailerUICollectionViewCell: YTSwiftyPlayerDelegate {
    func playerReady(_ player: YTSwiftyPlayer) {
        print(#function)
        // Player API is available after loading a video.
        // e.g. player.mute()
    }
    
    func player(_ player: YTSwiftyPlayer, didUpdateCurrentTime currentTime: Double) {
        print("\(#function): \(currentTime)")
    }
    
    func player(_ player: YTSwiftyPlayer, didChangeState state: YTSwiftyPlayerState) {
        print("\(#function): \(state)")
    }
    
    func player(_ player: YTSwiftyPlayer, didChangePlaybackRate playbackRate: Double) {
        print("\(#function): \(playbackRate)")
    }
    
    func player(_ player: YTSwiftyPlayer, didReceiveError error: YTSwiftyPlayerError) {
        print("\(#function): \(error)")
    }
    
    func player(_ player: YTSwiftyPlayer, didChangeQuality quality: YTSwiftyVideoQuality) {
        print("\(#function): \(quality)")
    }
    
    func apiDidChange(_ player: YTSwiftyPlayer) {
        print(#function)
    }
    
    func youtubeIframeAPIReady(_ player: YTSwiftyPlayer) {
        print(#function)
    }
    
    func youtubeIframeAPIFailedToLoad(_ player: YTSwiftyPlayer) {
        print(#function)
    }
}
