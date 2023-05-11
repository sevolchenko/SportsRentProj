abstract class ApplicationEvent {
  const ApplicationEvent();
}

class TriggerAppEvent extends ApplicationEvent {
  final int index;
  const TriggerAppEvent(this.index) : super();
}
