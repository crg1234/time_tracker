import { Controller } from "@hotwired/stimulus"

const BEFORE = 'BEFORE';
const DURING = 'DURING';
const AFTER = 'AFTER';

// Connects to data-controller="timer"
export default class extends Controller {
  static values = {
    interval: { default: 500, type: Number },

    from: String,
    to: String,
  };

  static targets = [
    'before',
    'during',
    'after',
    'fromTime',
    'toTime',
    'toTimeRelative',
    'startTime',
    'stopTime',
    'calculateTimeDifference'
  ];

  connect() {
    this._timer = setInterval(() => {
      this.update();
    }, this.intervalValue);

    this.setTimeValues();
    this.update();
  }

  startTimeTracker() {
    // console.log(this.startTimeTarget.innerHTML)
    console.log("Start Time", new Date())
    var startTimeTime = new Date().getTime();
    console.log(startTimeTime)
    var incrementer = 0;
    setInterval(() => {
      incrementer += 1
      console.log(incrementer)
    }, 1000);
    // var startTime = new Date();
    // console.log(startTime)
  }

  stopTimeTracker() {
    // console.log(this.stopTimeTarget.innerHTML)
    console.log("Stop Time", new Date())
    var stopTimeTime = new Date().getTime();
    console.log(stopTimeTime)
    // var stopTime = new Date();
    // console.log(stopTime)
  }

  calculateTimeDifference(startTimeTarget, stopTimeTarget) {
    // const timer_start = this.startTimeTracker()
    // const timer_stop = this.stopTimeTracker()
    console.log(this.startTimeTarget)
    console.log(this.stopTimeTarget)
  }

  getTimeData() {
    const from = this.hasFromValue && new Date(this.fromValue);
    const to = this.hasToValue && new Date(this.toValue);

    if (!from || !to) return;
    if (from > to) {
      throw new Error('From time must be after to time.');
    }

    const now = new Date();

    const status = (() => {
      if (now < from) return BEFORE;

      if (now >= from && now <= to) return DURING;

      return AFTER;
    })();

    return { from, to, now, status };
  }

  setTimeValues() {
    const { from, to, now } = this.getTimeData();
    const locale = this.localeValue;

    const formatter = new Intl.DateTimeFormat(locale, {
      dateStyle: 'short',
      timeStyle: 'short',
    });

    this.fromTimeTargets.forEach((element) => {
      element.setAttribute('datetime', from);
      element.innerText = formatter.format(from);
    });

    this.toTimeTargets.forEach((element) => {
      element.setAttribute('datetime', to);
      element.innerText = formatter.format(to);
    });

    const relativeFormatter = new Intl.RelativeTimeFormat(locale, {
      numeric: 'auto',
    });

    this.toTimeRelativeTargets.forEach((element) => {
      element.setAttribute('datetime', to);
      element.innerText = relativeFormatter.format(
        Math.round((now - from) / 1000),
        'seconds'
      );
    });
  }

  update() {
    const { status } = this.getTimeData();

    [
      [BEFORE, this.beforeTarget],
      [DURING, this.duringTarget],
      [AFTER, this.afterTarget],
    ].forEach(([key, element]) => {
      if (key === status) {
        element.style.removeProperty('display');
      } else {
        element.style.setProperty('display', 'none');
      }
    });

    this.setTimeValues();

    if (status === AFTER) {
      this.stopTimer();
    }
  }

  stopTimer() {
    const timer = this._timer;

    if (!timer) return;

    clearInterval(timer);
  }

  disconnect() {
    // ensure we clean up so the timer is not running if the element gets removed
    this.stopTimer();
  }
}
