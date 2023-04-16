/* SymbolGridApp.swift --> Editing Grids. Created by Miguel Torres on 14/04/2023 */

import SwiftUI

@main
struct SymbolGridApp: App {
    var body: some Scene {
        // Todas las aplicaciones en SwiftUI tienen un WindowGroup
        WindowGroup {
            // Un NavigationStack permite la navegación entre vistas mostrando una a la vez.
            NavigationStack {
                SymbolGrid() // La vista que se carga está definida en el archivo SymbolGrid.swift
            }
        }
    }
}

