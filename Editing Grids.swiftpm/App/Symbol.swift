/* Symbol.swift --> Editing Grids. Created by Miguel Torres on 14/04/2023 */

import SwiftUI

/// Esta estructura nos va a permitir definir el nombre de los SFSymbols de manera adecuada, con un identificador único y un protocolo que nos permite saber si dos instancias de esta estructura son iguales o diferentes con los operadores == o !=
struct Symbol: Identifiable, Equatable {
	var id = UUID()
	var name: String
}
