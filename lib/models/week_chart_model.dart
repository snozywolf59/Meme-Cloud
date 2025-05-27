import 'package:memecloud/apis/zingmp3/endpoints.dart';
import 'package:memecloud/models/song_model.dart';

class ChartSong {
  final SongModel song;
  final int rankingStatus;
  final int weeklyRanking;
  ChartSong._({
    required this.song,
    required this.rankingStatus,
    required this.weeklyRanking,
  });

  static ChartSong fromJson<T>(Map<String, dynamic> json) {
    if (T == ZingMp3Api) {
      return ChartSong._(
        song: SongModel.fromJson<T>(json),
        rankingStatus: json['rakingStatus'],
        weeklyRanking: json['weeklyRanking']
      );
    }
    throw UnsupportedError('Cannot parse chart song for type $T');
  }

  static List<ChartSong> fromListJson<T>(List list) {
    return list.map((json) => ChartSong.fromJson<T>(json)).toList();
  }
}

class WeekChartModel {
  final String name;
  final String bannerUrl;
  final String startDate;
  final String endDate;
  final List<ChartSong> chartSongs;

  WeekChartModel._(
    this.name, {
    required this.bannerUrl,
    required this.startDate,
    required this.endDate,
    required this.chartSongs,
  });

  static WeekChartModel fromJson<T>(String name, Map<String, dynamic> json) {
    if (T == ZingMp3Api) {
      return WeekChartModel._(
        name,
        bannerUrl: json['banner'],
        startDate: json['startDate'],
        endDate: json['endDate'],
        chartSongs: ChartSong.fromListJson<ZingMp3Api>(json['items'])
      );
    }
    throw UnsupportedError('Cannot parse week chart for type $T');
  }

  List<SongModel> get songs => chartSongs.map((e) => e.song).toList();
}
