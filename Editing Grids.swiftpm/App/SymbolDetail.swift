/* SymbolDetail.swift --> Editing Grids. Created by Miguel Torres on 14/04/2023 */

import SwiftUI

/// Vista encargada de mostrar una imagen definida a partir de un SFSymbol.
struct SymbolDetail: View {
    // Propiedad de esta vista que se utiliza para crear una imagen a partir de un SFSymbol
    var symbol: Symbol // Los SFSymbols son de tipo "Symbol", una estructura que creamos para este proyecto.

    var body: some View {
        VStack {
            Text(symbol.name)
                .font(.system(.largeTitle, design: .rounded))
            
            // Como ya habíamos visto, las imágenes se pueden crear a partir de los SFSymbols, usando como parámetro "systemName"
            Image(systemName: symbol.name)
                .resizable()
                .scaledToFit()
                .symbolRenderingMode(.hierarchical)
                .foregroundColor(Color.gray)
        }
        .padding()
    }
}

struct Details_Previews: PreviewProvider {
    static var previews: some View {
        SymbolDetail(symbol: Symbol(name: "magnifyingglass"))
    }
}
