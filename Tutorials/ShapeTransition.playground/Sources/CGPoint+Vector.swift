import SwiftUI

public extension CGPoint {
    
    func rotated(around: CGPoint, angle: Angle) -> CGPoint {
        let s = sin(angle.radians)
        let c = cos(angle.radians)

        var p = self
        p.x -= around.x
        p.y -= around.y

        let xnew = p.x * c - p.y * s;
        let ynew = p.x * s + p.y * c;

        p.x = xnew + around.x;
        p.y = ynew + around.y
        return p
    }
    
    func offset(x: CGFloat = 0.0, y: CGFloat = 0.0) -> CGPoint {
        .init(x: self.x + x,
              y: self.y + y)
    }
}
