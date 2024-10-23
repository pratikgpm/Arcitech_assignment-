class AppUser {
  String? uid;
  String? email;
  String? displayName;
  String? photoURL;

  AppUser({
    this.uid,
    this.email,
    this.displayName,
    this.photoURL,
  });

  AppUser copyWith({
    String? uid,
    String? email,
    String? displayName,
    String? photoURL,
  }) {
    return AppUser(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      photoURL: photoURL ?? this.photoURL,
    );
  }
}
