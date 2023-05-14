abstract class ProfileEvent {
  const ProfileEvent();
}

class NameEvent extends ProfileEvent {
  final String name;
  const NameEvent(this.name);
}

class EmailEvent extends ProfileEvent {
  final String email;
  const EmailEvent(this.email);
}

