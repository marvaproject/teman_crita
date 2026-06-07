class MatchingRequest {
  const MatchingRequest({
    required this.story,
    required this.issueTags,
  });

  final String story;
  final List<String> issueTags;

  bool get isValid => story.trim().isNotEmpty && issueTags.length <= 3;
}
