import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerAdsScreen extends StatefulWidget {
  const BannerAdsScreen({super.key});

  @override
  State<BannerAdsScreen> createState() => _BannerAdsScreenState();
}

class _BannerAdsScreenState extends State<BannerAdsScreen> {
  /// banner
  BannerAd? _bannerAd;
  bool _isLoaded = false;

  void _loadBanner() {
    if (_bannerAd != null && _isLoaded) return;

    _bannerAd?.dispose();

    _bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: 'ca-app-pub-3940256099942544/6300978111', // Test ID
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          debugPrint("✅ Banner Loaded");
          setState(() => _isLoaded = true);
        },
        onAdFailedToLoad: (ad, error) {
          debugPrint("❌ Banner Failed: ${error.code} - ${error.message}");
          ad.dispose();
          setState(() {
            _isLoaded = false;
            _bannerAd = null;
          });
        },
      ),
      request: const AdRequest(),
    )..load();
  }

  /// rewarded
  RewardedAd? _rewardedAd;
  bool _isRewardedLoading = false;

  void _loadRewardedAd() {
    if (_isRewardedLoading) return;

    setState(() => _isRewardedLoading = true);

    RewardedAd.load(
      adUnitId: 'ca-app-pub-3940256099942544/5224354917', // ✅ Test Rewarded ID
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          debugPrint('✅ RewardedAd Loaded');
          setState(() {
            _isRewardedLoading = false;
            _rewardedAd = ad;
          });
          _showRewardedAd();
        },
        onAdFailedToLoad: (LoadAdError error) {
          debugPrint('❌ RewardedAd Failed to Load: $error');
          setState(() {
            _isRewardedLoading = false;
            _rewardedAd = null;
          });
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('فشل تحميل الإعلان، حاول مرة ثانية'),
              ),
            );
          }
        },
      ),
    );
  }

  void _showRewardedAd() {
    if (_rewardedAd == null) {
      debugPrint('ℹ️ RewardedAd is not ready yet');
      return;
    }

    _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) {
        debugPrint('👀 RewardedAd showed');
      },
      onAdDismissedFullScreenContent: (ad) {
        debugPrint('🔚 RewardedAd dismissed');
        ad.dispose();
        setState(() {
          _rewardedAd = null;
        });
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        debugPrint('❌ Failed to show RewardedAd: $error');
        ad.dispose();
        setState(() {
          _rewardedAd = null;
        });
      },
    );

    _rewardedAd!.show(
      onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
        debugPrint('🎁 User earned reward: ${reward.amount} ${reward.type}');
        // هون بتحط اللوجيك تبعك (فتح feature, إضافة نقاط, الخ...)
      },
    );

    // بعد عرض الإعلان، نخلي المتغير null عشان نحمّل واحد جديد لاحقاً
    _rewardedAd = null;
  }

  void _onCenterButtonPressed() {
    _loadRewardedAd();
  }

  @override
  void initState() {
    super.initState();
    _loadBanner();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Banner Ads with BNB"),
        centerTitle: true,
      ),
      bottomNavigationBar: _isLoaded && _bannerAd != null
          ? SizedBox(
              width: _bannerAd!.size.width.toDouble(),
              height: _bannerAd!.size.height.toDouble(),
              child: AdWidget(ad: _bannerAd!),
            )
          : CircularProgressIndicator(),
      floatingActionButton: FloatingActionButton(
        onPressed: _onCenterButtonPressed,
        child: _isRewardedLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : const Icon(Icons.play_circle_fill),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }
}
