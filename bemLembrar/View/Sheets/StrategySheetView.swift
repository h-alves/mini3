//
//  StrategySheetView.swift
//  bemLembrar
//
//  Created by Henrique Semmer on 12/11/23.
//

import SwiftUI

struct StrategySheetView: View {
    @ObservedObject var viewModel: UserViewModel
    
    var body: some View {
        VStack {
            Text("ESTRATÉGIAS")
            
            ForEach(viewModel.strategies, id: \.name) { strategy in
                HStack {
                    Button {
                        viewModel.selectStrategy(strategy: strategy)
                    } label: {
                        Image(systemName: strategy.isSelected ? "square.fill" : "square")
                    }
                    
                    Text(strategy.name)
                }
            }
            
            Button {
                viewModel.saveStrategies()
            } label: {
                Text("Done")
            }
        }
    }
}

#Preview {
    StrategySheetView(viewModel: UserViewModel())
}
