//
//  GuideView.swift
//  bemLembrar
//
//  Created by Henrique Semmer on 15/11/23.
//

import SwiftUI

struct GuideView: View {
    @Binding var onboarding: Bool
    
    @State var selectIndex = 0
    
    let descriptionTexts = ["Comece criando sua lista de clientes a partir dos seus contatos.", "Identifique as clientes em sua lista de contatos e registre suas preferências!", "E receba notificações sobre suas clientes para fortalecer seus laços."]
    
    var body: some View {
        ZStack {
            Color.branco
                .ignoresSafeArea(edges: .top)
            
            Color.verde
                .ignoresSafeArea(edges: .bottom)
            
            VStack(spacing: 48) {
                VStack(spacing: 64) {
                    HStack(alignment: .center, spacing: 3) {
                        ForEach(0..<3, id: \.self) { index in
                            if index != self.selectIndex {
                                Image(systemName: "circle")
                                    .foregroundStyle(.verde)
                                    .font(.system(size: 10))
                                    .fontWeight(.semibold)
                            } else {
                                Image(systemName: "circle.fill")
                                    .foregroundStyle(.verde)
                                    .font(.system(size: 10))
                                    .fontWeight(.semibold)
                            }
                        }
                    }
                    .animation(.default, value: selectIndex)
                    .frame(maxWidth: .infinity, maxHeight: 20)
                    
                    TabView(selection: $selectIndex) {
                        ForEach(0..<3, id: \.self) { index in
                            VStack(spacing: 32) {
                                HStack(spacing: 16) {
                                    ZStack {
                                        AdaptiveView {
                                            Image("flowerNumberDark")
                                                .resizable()
                                                .frame(width: 83, height: 81)
                                        } dark: {
                                            Image("flowerNumberDark")
                                                .resizable()
                                                .frame(width: 83, height: 81)
                                        }
                                        
                                        Text("\(selectIndex+1)")
                                            .foregroundStyle(.branco)
                                            .font(.largeTitle)
                                            .fontWeight(.bold)
                                    }
                                    
                                    Text(descriptionTexts[selectIndex])
                                        .foregroundStyle(.preto)
                                        .font(.headline)
                                }
                                
                                Image("onboardingImage\(selectIndex+1)")
                                    .resizable()
                                    .frame(width: 305, height: 296)
                            }
                            .padding(.horizontal, 32)
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                }
                .padding(.top, 24)
                .padding(.bottom, 100)
                .background(.branco)
                .clipShape(
                    .rect (
                        topLeadingRadius: 0,
                        bottomLeadingRadius: 32,
                        bottomTrailingRadius: 32,
                        topTrailingRadius: 0
                    )
                )
                .shadow(radius: 5, y: 12)
                
                if selectIndex < 2 {
                    BLButton(symbol: "arrow.right", text: "Próximo", disabled: false, opposite: true, color: .branco, textColor: .verde) {
                        withAnimation {
                            selectIndex+=1
                        }
                    }
                    .padding(.horizontal, 32)
                } else {
                    BLButton(symbol: "", text: "Criar conta", disabled: false, opposite: false, color: .branco, textColor: .verde) {
                        NotificationManager.shared.requestPermission()
                        RouterService.shared.navigate(.allClients)
                    }
                    .padding(.horizontal, 32)
                }
                
                Spacer()
            }
        }
        
//        VStack {
//            Spacer()
//            
//            VStack(alignment: .leading, spacing: 10) {
//                Text("Informações das suas clientes sempre bem lembradas!")
//                    .foregroundStyle(.preto)
//                    .font(.largeTitle)
//                    .fontWeight(.semibold)
//                
//                Text("Monte sua lista de clientes e salve tudo sobre elas para facilitar o contato. Simples assim:")
//                    .foregroundStyle(.preto)
//                    .font(.body)
//            }
//            .padding(.horizontal, 32)
//            
//            Spacer()
//            
//            VStack(spacing: 24) {
//                TabView(selection: $selectIndex) {
//                    ForEach(0..<3, id: \.self) { index in
//                        VStack {
//                            HStack {
//                                Text("\(selectIndex+1)")
//                                    .foregroundStyle(.preto)
//                                    .font(.largeTitle)
//                                    .fontWeight(.bold)
//                                    .padding()
//                                    .background(.rosa)
//                                    .clipShape(Circle())
//                                
//                                Text(descriptionTexts[selectIndex])
//                                    .foregroundStyle(.preto)
//                                    .font(.headline)
//                            }
//                            
//                            Image("onboardingImage\(selectIndex+1)")
//                                .resizable()
//                                .frame(width: 225, height: 225)
//                        }
//                    }
//                    .padding()
//                    .frame(maxWidth: 329)
//                    .background(.branco)
//                    .clipShape (
//                        RoundedRectangle(cornerRadius: 12)
//                    )
//                    .shadow(radius: 5)
//                }
//                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
//                
//                HStack(alignment: .center, spacing: 4) {
//                    ForEach((0..<3), id: \.self) { index in
//                        if index != self.selectIndex {
//                            Image(systemName: "circle")
//                                .foregroundStyle(.preto)
//                                .font(.system(size: 14))
//                                .fontWeight(.semibold)
//                        } else {
//                            Image(systemName: "circle.fill")
//                                .foregroundStyle(.preto)
//                                .font(.system(size: 14))
//                                .fontWeight(.semibold)
//                        }
//                    }
//                }
//                .animation(.default, value: selectIndex)
//                .frame(maxWidth: .infinity, maxHeight: 20)
//            }
//            
//            Spacer()
//            
//            if selectIndex >= 2 {
//                BLButton(symbol: "", text: "Começar", disabled: false, opposite: false, color: .branco, textColor: .verde) {
//                    onboarding = false
//                    RouterService.shared.navigate(.allClients)
//                }
//                .padding(.horizontal, 32)
//            } else {
//                Button {
//                    print("Clicado")
//                } label: {
//                    Text("Começar")
//                        .foregroundStyle(.rosa)
//                        .font(.title3)
//                        .fontWeight(.semibold)
//                        .padding(.horizontal, 14)
//                        .padding(.vertical, 8)
//                        .background(.rosa)
//                        .clipShape(RoundedRectangle(cornerRadius: 14))
//                }
//                .disabled(true)
//            }
//        }
////        .padding(.horizontal, 32)
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .background(.rosa)
//        .onChange(of: selectIndex, perform: { value in
//            if selectIndex == 2 {
//                NotificationManager.shared.requestPermission()
//            }
//        })
    }
}

#Preview {
    GuideView(onboarding: .constant(true))
}
