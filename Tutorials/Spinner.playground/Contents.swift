import SwiftUI
import PlaygroundSupport

struct BackgroundCircle: Shape {
    var progress: Double
    let lineWidth: CGFloat
    
    var animatableData: Double {
        get { progress }
        set { progress = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        let halfWidth = rect.width / 2.0 - lineWidth / 2.0
        let initialCircleSize = lineWidth / 4.0
        
        var path = Path()
        path.addArc(center: .init(x: rect.midX,
                                  y: rect.midY),
                    radius: lineWidth + initialCircleSize + (halfWidth - lineWidth) * sin(progress * .pi),
                    startAngle: .radians(0.0),
                    endAngle: .radians(.pi * 2.0),
                    clockwise: false)
        return path
    }
}

struct SpinnerCircle: Shape {
    var progress: Double
    let lineWidth: CGFloat
    
    var animatableData: Double {
        get { progress }
        set { progress = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        let end = progress * progress * .pi * 2.0
        let start = end + end
        
        let halfWidth = rect.width / 2.0 - lineWidth / 2.0
        let initialCircleSize = lineWidth / 4.0
        
        var path = Path()
        path.addArc(center: .init(x: rect.midX,
                                  y: rect.midY),
                    radius: initialCircleSize * (1.0 - progress) + halfWidth * sin(progress * .pi),
                    startAngle: .radians(start),
                    endAngle: .radians(end),
                    clockwise: false)
        return path
    }
}

struct SpinnerView: View {
    @State
    var progress = 0.0
    
    let lineWidth = 10.0
    
    var animation: Animation {
        .easeInOut(duration: 2.0)
        .repeatForever(autoreverses: false)
    }
    
    var body: some View {
        ZStack {
            BackgroundCircle(progress: progress,
                             lineWidth: lineWidth)
            .stroke(
                .gray,
                style: .init(lineWidth: lineWidth)
            )
            
            SpinnerCircle(progress: progress,
                          lineWidth: lineWidth)
            .stroke(
                .white,
                style: .init(
                    lineWidth: lineWidth + (lineWidth / 2.0) * progress,
                    lineCap: .round
                )
            )
        }
        .onAppear {
            withAnimation(animation) {
                progress = 1.0
            }
        }
    }
}

struct ContentView: View {
    
    var body: some View {
        ZStack {
            SpinnerView()
                .frame(width: 100.0, height: 100.0)
        }
        .frame(width: 300.0, height: 300.0)
        .background(.black)
    }
}

PlaygroundPage.current.setLiveView(ContentView())
