/* SymbolGrid.swift --> Editing Grids. Created by Miguel Torres on 14/04/2023 */

import SwiftUI

/// Crea una cuadrícula de SFSymbols a partir de un arreglo de SFSymbols.
struct SymbolGrid: View {

    // Variables de estado que determinan si estamos agregando un nuevo símbolo o si estamos editando los que ya tenemos.
    @State private var isAddingSymbol = false
    @State private var isEditing = false

    // Empezamos la cuadrícula con 3 columnas.
    private static let initialColumns = 3
    @State private var selectedSymbol: Symbol?
    @State private var numColumns = initialColumns
    @State private var gridColumns = Array(repeating: GridItem(.flexible()), count: initialColumns)
    
    // Arreglo mutable de todos los símbolos que tenemos originalmente en "My Symbols".
	@State private var symbols = [
		Symbol(name: "tshirt"),
		Symbol(name: "eyes"),
		Symbol(name: "eyebrow"),
		Symbol(name: "nose"),
		Symbol(name: "mustache"),
		Symbol(name: "mouth"),
		Symbol(name: "eyeglasses"),
		Symbol(name: "facemask"),
		Symbol(name: "brain.head.profile"),
		Symbol(name: "brain"),
		Symbol(name: "icloud"),
		Symbol(name: "theatermasks.fill"),
	]
    
    // Controla el texto que indica cuántas columnas queremos en nuestra cuadrícula, si estamos en modo edición.
    var columnsText: String {
        numColumns > 1 ? "\(numColumns) Columns" : "1 Column"
    }

    var body: some View {
        // Iniciamos un VStack que tiene un Stepper opcional, y el ScrollView para las imágenes
        VStack {
            // Objeto "Stepper" que únicamente aparece si tenemos habilitada la opción de editar.
            if isEditing {
                // Se muestra el texto al lado del Stepper, con la variable "numColummns" enlazada al Stepper, de manera que cada vez que se presionan sus botones, la variable enlazada se modifica.
                Stepper(columnsText, value: $numColumns, in: 1...6, step: 1) { _ in // El siguiente bloque se ejecuda cada vez que se presiona un botón del Stepper.
                    withAnimation { gridColumns = Array(repeating: GridItem(.flexible()), count: numColumns) }
                }
                .padding()
            }

            // Iniciamos el Scroll View que contiene a todos los símbolos.
            ScrollView {
                // Un LazyVGrid crea la cuadrícula de elementos, que agregamos en un Scroll View por si no nos alcanza el espacio.
                LazyVGrid(columns: gridColumns) {
                    // ForEach necesita un identificador en el arreglo "symbols" para funcionar, pero como "symbols" es un arreglo de objetos tipo "Symbol", que adoptan el protocolo "Identifiable", ya no es necesario indicar un Id para poder usar el ForEach
                    ForEach(symbols) { symbol in
                        // Cada símbolo es un botón que lleva a una vista secundaria que se define en "destination:" y es la vista que recibe como parámetro el objeto "symbol" que estamos usando en ese momento.
						NavigationLink(destination: SymbolDetail(symbol: symbol)) {
                            // Usamos un ZStack para encimar el botón de eliminar cuando estemos en modo "editar"
                            ZStack(alignment: .topTrailing) {
								Image(systemName: symbol.name)
                                    .resizable()
                                    .scaledToFit()
                                    .symbolRenderingMode(.hierarchical)
                                    .foregroundColor(.accentColor)
                                    .ignoresSafeArea(.container, edges: .bottom)
                                    .cornerRadius(8)
                                
                                if isEditing {
                                    Button {
										guard let index = symbols.firstIndex(of: symbol) else { return }
                                        withAnimation {
                                            _ = symbols.remove(at: index)
                                        }
                                    } label: {
                                        Image(systemName: "xmark.square.fill")
                                                    .font(.title)
                                                    .symbolRenderingMode(.palette)
                                                    .foregroundStyle(.white, Color.red)
                                    }
                                    .offset(x: 7, y: -7)
                                }
                            }
                            .padding()
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
        }
        .navigationTitle("My Symbols")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $isAddingSymbol, onDismiss: addSymbol) {
            SymbolPicker(symbol: $selectedSymbol)
        }
        .toolbar { // Esta es la barra de herramientas (botones) de todo el VStack.
            ToolbarItem(placement: .navigationBarLeading) { // Primer herramienta, posicionada en el "leading" de la navigationBar
                Button(isEditing ? "Done" : "Edit") {
                    // Usamos el método ".toggle()" que tienen las variables boolean para alternar su valor entre verdadero y falso.
                    withAnimation { isEditing.toggle() }
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                // El botón de "+" cambia el estado de "isAddingSymbol" a "true" y se desactiva si "isEditing" es "true"
                Button {
                    isAddingSymbol = true
                } label: {
                    Image(systemName: "plus")
                }
                .disabled(isEditing)
            }
        }

    }
    
    func addSymbol() {
        guard let name = selectedSymbol else { return }
        withAnimation {
            symbols.insert(name, at: 0)
        }
    }
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        SymbolGrid()
    }
}
