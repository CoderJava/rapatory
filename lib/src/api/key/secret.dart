class Secret {
  final String twitterConsumerKey;
  final String twitterConsumerSecret;

  Secret({this.twitterConsumerKey = '', this.twitterConsumerSecret = ''});

  factory Secret.fromJson(Map<String, dynamic> json) {
    return Secret(
      twitterConsumerKey: json['twitter_consumer_key'],
      twitterConsumerSecret: json['twitter_consumer_secret'],
    );
  }
}
