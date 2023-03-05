//: A UIKit based Playground for presenting user interface
  
import SwiftUI
import PlaygroundSupport
import simd

struct PhongShadingView: View {
    
    @State
    var progress = 0.5
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Slider(value: $progress, in: 0.0...1.0)
                    .frame(width: 150.0)
            }
            
            sphere
                .frame(width: 200.0, height: 200.0)
        }
        .frame(width: 300.0, height: 300.0)
    }
    
    var convertNormalMatrix: ColorMatrix {
        var colorMatrix = ColorMatrix()
        colorMatrix.r1 = 2.0
        colorMatrix.g2 = 2.0
        colorMatrix.b3 = 2.0
        colorMatrix.a4 = 2.0
        
        colorMatrix.r5 = -1.0
        colorMatrix.g5 = -1.0
        colorMatrix.b5 = -1.0
        colorMatrix.a5 = -1.0
        return colorMatrix
    }

    var lightMatrix: ColorMatrix {
        let light = SIMD2<Float>(x: 1.0, y: 0.0)
            .rotated(angle: Float(.pi / 2.0 * (1.0 - progress)))
            .normalized()

        var colorMatrix = ColorMatrix()
        colorMatrix.r1 = light.x
        colorMatrix.g2 = light.y
        colorMatrix.b3 = 0.0
        return colorMatrix
    }
    
    var sumMatrix: ColorMatrix {
        var matrix = ColorMatrix()
        matrix.r1 = 1.0
        matrix.r2 = 1.0
        matrix.r3 = 1.0
        matrix.r4 = 1.0

        matrix.g1 = 1.0
        matrix.g2 = 1.0
        matrix.g3 = 1.0
        matrix.g4 = 1.0

        matrix.b1 = 1.0
        matrix.b2 = 1.0
        matrix.b3 = 1.0
        matrix.b4 = 1.0

        matrix.a1 = 0.0
        matrix.a2 = 0.0
        matrix.a3 = 0.0
        matrix.a4 = 0.0
        matrix.a5 = 1.0

        return matrix
    }
    
    var sphere: some View {
        Canvas(opaque: true, colorMode: .linear) { context, size in
            context.drawLayer { context in
                context.addFilter(.colorMatrix(sumMatrix)) // r + g + b + a
                context.addFilter(.colorMatrix(lightMatrix)) // multipy with light
                context.addFilter(.colorMatrix(convertNormalMatrix)) // convert from 0.0...1.0 to -1.0...1.0
                
                let image = #imageLiteral(resourceName: "normal_map.png")
                context.draw(Image(uiImage: image), in: CGRect(origin: .zero, size: size))
            }
        }
    }
}

extension SIMD2 where Scalar == Float {
    
    func rotated(angle: Scalar) -> SIMD2<Scalar> {
        let cs = cos(angle)
        let sn = sin(angle)
        return .init(x * cs - y * sn, x * sn + y * cs)
    }
    
    func normalized() -> SIMD2<Scalar> {
        normalize(self)
    }
}


PlaygroundPage.current.setLiveView(PhongShadingView())
