import SwiftUI
import PlaygroundSupport

struct ExpandableShape: Shape {
    var progress: Double
    
    var animatableData: Double {
        get { progress }
        set { progress = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        let shapeWidth = 250.0
        let shapeHeight = 220.0
        
        let reversProgress = 1.0 - progress
        
        let position = CGPoint(x: (rect.width - shapeWidth) / 2.0,
                                   y: (rect.height - shapeHeight) / 2.0)
        
        let topOffsets = CGSize(width: shapeWidth / 2.0, height: 0.0)
        
        let bottomEdge = CGSize(width: 30.0, height: 10.0)
        let bottomInnerEdge = CGSize(width: bottomEdge.width, height: 80.0)
        
        let topEdge = CGSize(width: 0.0, height: 70.0)
        let topInnerEdge = CGSize(width: 75.0, height: 45.0)
        
        let bottomInnerPosition = CGSize(width: shapeWidth / 2.0,
                                         height: 25.0)
        
        let circleSize = 70.0 * reversProgress
        let circularCorner = circleSize * 0.55
        
        let innerCircleSize = 60.0
        let innerCircularCorner = innerCircleSize * 0.55
        
        var path = Path()
        
        // BottomLeft
        let bottomLeft = CGPoint(x: interpolate(from: position.x + bottomEdge.width,
                                                to: 0.0,
                                                progress: progress),
                                 y: interpolate(from: (position.y + shapeHeight - bottomEdge.height),
                                                to: rect.height,
                                                progress: progress))
        let bottomSideRotation = 45.0
        let bottomLeft1 = bottomLeft
            .offset(y: -circularCorner)
            .rotated(around: bottomLeft, angle: .degrees(-bottomSideRotation))
        let bottomLeft2 = bottomLeft
            .offset(y: circularCorner)
            .rotated(around: bottomLeft, angle: .degrees(-bottomSideRotation))
        
        let bottomInnerLeft = CGPoint(x: interpolate(from: position.x + bottomInnerEdge.width,
                                                     to: 0.0,
                                                     progress: progress),
                                      y: position.y + shapeHeight - bottomInnerEdge.height)
        let bottomInnerRotation = 10.0 * reversProgress
        let bottomInnerLeft1 = bottomInnerLeft
            .offset(y: innerCircularCorner)
            .rotated(around: bottomInnerLeft, angle: .degrees(-bottomInnerRotation))
        let bottomInnerLeft2 = bottomInnerLeft
            .offset(y: -innerCircularCorner)
            .rotated(around: bottomInnerLeft, angle: .degrees(-bottomInnerRotation))
        
        path.move(to: bottomLeft)
        path.addCurve(to: bottomInnerLeft,
                      control1: bottomLeft1,
                      control2: bottomInnerLeft1)
        
        // Top Left
        let topEdgeRotation = 20.0
        let topLeft = CGPoint(x: interpolate(from: position.x + topEdge.width,
                                             to: 0.0,
                                             progress: progress),
                              y: interpolate(from: position.y + topEdge.height,
                                             to: 0.0,
                                             progress: progress))
        let topLeft1 = topLeft
            .offset(y: circularCorner)
            .rotated(around: topLeft, angle: .degrees(topEdgeRotation))
        let topLeft2 = topLeft
            .offset(y: -circularCorner)
            .rotated(around: topLeft, angle: .degrees(topEdgeRotation))
        
        let topInnerLeft = CGPoint(x: interpolate(from: position.x + topInnerEdge.width,
                                                  to: rect.width / 4.0,
                                                  progress: progress),
                                   y: interpolate(from: position.y + topInnerEdge.height,
                                                  to: 0.0,
                                                  progress: progress))
        let topInnerRotation = 45.0 * reversProgress
        let topInnerLeft1 = topInnerLeft
            .offset(x: -innerCircularCorner)
            .rotated(around: topInnerLeft, angle: .degrees(-topInnerRotation))
        let topInnerLeft2 = topInnerLeft
            .offset(x: innerCircularCorner)
            .rotated(around: topInnerLeft, angle: .degrees(-topInnerRotation))
        
        path.addCurve(to: topLeft,
                      control1: bottomInnerLeft2,
                      control2: topLeft1)
        path.addCurve(to: topInnerLeft,
                      control1: topLeft2,
                      control2: topInnerLeft1)
        
        // Top circle
        let top = CGPoint(x: position.x + topOffsets.width,
                          y: (position.y + topOffsets.height) * reversProgress)
        let top1 = top.offset(x: -circularCorner)
        let top2 = top.offset(x: circularCorner)
        
        let topInnerRight = CGPoint(x: interpolate(from: position.x + shapeWidth - topInnerEdge.width,
                                                   to: rect.width / 4.0 * 3.0,
                                                   progress: progress),
                                    y: interpolate(from: position.y + topInnerEdge.height,
                                                   to: 0.0,
                                                   progress: progress))
        let topInnerRight1 = topInnerRight
            .offset(x: -innerCircularCorner)
            .rotated(around: topInnerRight, angle: .degrees(topInnerRotation))
        let topInnerRight2 = topInnerRight
            .offset(x: innerCircularCorner)
            .rotated(around: topInnerRight, angle: .degrees(topInnerRotation))
        
        path.addCurve(to: top,
                      control1: topInnerLeft2,
                      control2: top1)
        path.addCurve(to: topInnerRight,
                      control1: top2,
                      control2: topInnerRight1)
        
        // Top right
        let topRight = CGPoint(x: interpolate(from: position.x + shapeWidth - topEdge.width,
                                              to: rect.width,
                                              progress: progress),
                               y: interpolate(from: position.y + topEdge.height,
                                              to: 0.0,
                                              progress: progress))
        let topRight1 = topRight
            .offset(y: -circularCorner)
            .rotated(around: topRight, angle: .degrees(-topEdgeRotation))
        let topRight2 = topRight
            .offset(y: circularCorner)
            .rotated(around: topRight, angle: .degrees(-topEdgeRotation))
        
        let bottomInnerRight = CGPoint(x: interpolate(from: position.x + shapeWidth - bottomInnerEdge.width,
                                                      to: rect.width,
                                                      progress: progress),
                                       y: position.y + shapeHeight - bottomInnerEdge.height)
        let bottomInnerRight1 = bottomInnerRight
            .offset(y: -innerCircularCorner)
            .rotated(around: bottomInnerRight, angle: .degrees(bottomInnerRotation))
        let bottomInnerRight2 = bottomInnerRight
            .offset(y: innerCircularCorner)
            .rotated(around: bottomInnerRight, angle: .degrees(bottomInnerRotation))
        
        path.addCurve(to: topRight,
                      control1: topInnerRight2,
                      control2: topRight1)
        
        path.addCurve(to: bottomInnerRight,
                      control1: topRight2,
                      control2: bottomInnerRight1)
        
        // Bottom right
        let bottomRight = CGPoint(x: interpolate(from: position.x + shapeWidth - bottomEdge.width,
                                                 to: rect.width,
                                                 progress: progress),
                                  y: interpolate(from: position.y + shapeHeight - bottomEdge.height,
                                                 to: rect.height,
                                                 progress: progress))
        let bottomRight1 = bottomRight
            .offset(y: -circularCorner)
            .rotated(around: bottomRight, angle: .degrees(bottomSideRotation))
        let bottomRight2 = bottomRight
            .offset(y: circularCorner)
            .rotated(around: bottomRight, angle: .degrees(bottomSideRotation))
        
        let bottomInner = CGPoint(x: position.x + bottomInnerPosition.width,
                                  y: interpolate(from: position.y + shapeHeight - bottomInnerPosition.height,
                                                 to: rect.height,
                                                 progress: progress))
        let bottomInner1 = bottomInner.offset(x: innerCircularCorner)
        let bottomInner2 = bottomInner.offset(x: -innerCircularCorner)
        
        path.addCurve(to: bottomRight,
                      control1: bottomInnerRight2,
                      control2: bottomRight1)
        path.addCurve(to: bottomInner,
                      control1: bottomRight2,
                      control2: bottomInner1)
        path.addCurve(to: bottomLeft,
                      control1: bottomInner2,
                      control2: bottomLeft2)
        return path
    }
}

struct ContentView: View {
    
    @State
    var isFullScreen = false
    
    var body: some View {
        ZStack {
            ExpandableShape(
                progress: isFullScreen ? 1.0 : 0.0
            )
                .fill(.purple)
            VStack(spacing: 80.0) {
                Image(uiImage: #imageLiteral(resourceName: "illustration 1.png")) // Illustration from icons8.com
                
                if isFullScreen {
                    Text("WELCOME!")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                }
            }
        }
        .frame(width: 400.0, height: 700.0)
        .ignoresSafeArea()
        .onTapGesture {
            withAnimation {
                isFullScreen.toggle()
            }
        }
    }
}

PlaygroundPage.current.setLiveView(ContentView())
