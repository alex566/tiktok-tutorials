import CoreGraphics

public func interpolate(from: CGFloat, to: CGFloat, progress: CGFloat) -> CGFloat {
    (to - from) * progress + from
}
