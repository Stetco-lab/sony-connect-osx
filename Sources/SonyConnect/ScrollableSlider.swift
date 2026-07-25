import AppKit

// NSSlider ignores the scroll wheel by default, which makes fine-grained
// values annoying to hit by dragging a tiny knob. This nudges the value one
// step per wheel tick and fires the slider's action immediately, regardless
// of isContinuous — each tick is already a deliberate, discrete step.
final class ScrollableSlider: NSSlider {
    override func scrollWheel(with event: NSEvent) {
        guard isEnabled, event.deltaY != 0 else {
            super.scrollWheel(with: event)
            return
        }
        let step: Double = event.deltaY > 0 ? 1 : -1
        let newValue = min(maxValue, max(minValue, doubleValue + step))
        guard newValue != doubleValue else { return }
        doubleValue = newValue
        sendAction(action, to: target)
    }
}
