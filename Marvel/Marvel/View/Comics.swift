//
//  Comics.swift
//  Marvel
//
//  Created by User14 on 2022/12/27.
//

import SwiftUI
import SDWebImageSwiftUI


struct Comics: View {
    
    @EnvironmentObject var homeData: HomeViewModel
    var body: some View {
        NavigationView
        {
            ScrollView(.vertical, showsIndicators: false,
                       content:{
                        if homeData.fetchedComics.isEmpty{
                            ProgressView()
                                .padding(.top,30)
                        }
                        else{
                            
                            VStack(spacing: 15)
                            { 
                                ForEach(homeData.fetchedComics){comic in
                                    
                                    ComicRowView(character: comic)
                                }
                                
                                
                                if homeData.offset == homeData.fetchedComics.count{
                                    ProgressView()
                                        .padding(.vertical)
                                        .onAppear(perform:{
                                            print("fetching new data ....")
                                            
                                            homeData.fetchComics()
                                        })
                                }
                                else {
                                    
                                    GeometryReader{reader -> Color in
                                        
                                        let minY = reader.frame(in: .global).minY
                                        let heigt = UIScreen.main.bounds.height / 1.3
                                        
                                        if !homeData.fetchedComics.isEmpty && minY < heigt{
                                            print("last")
                                            DispatchQueue.main.async {
                                                homeData.offset = homeData.fetchedComics.count
                                            }
                                            
                                        }
                                        return Color.clear
                                    }
                                    .frame(width:20, height:20)
                                }
                                
                            }
                            .padding(.bottom)
                        }
                        
                       })
                .navigationTitle("marvel's Comics")
        }
        .onAppear(perform:{
            if homeData.fetchedComics.isEmpty
            {
                homeData.fetchComics()
            }
        })
    }
}

struct Comics_Previews: PreviewProvider {
    static var previews: some View {
        Comics()
    }
}
struct ComicRowView : View {
    var character : Comic
    
    var body : some View {
        
        HStack(alignment: .top,spacing: 15){
            
            WebImage(url: extracImage(data: character.thumbnail))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 150,height : 150)
                .cornerRadius(8)
            
           
            
            VStack(alignment: .leading, spacing: 8, content: {
                
                Text(character.title)
                    .font(.title3)
                    .fontWeight(.bold)
                
                if let description = character.description{
                    
                    Text(description)
                        .font(.caption)
                        .foregroundColor(.gray)
                        .lineLimit(4)
                        .multilineTextAlignment(.leading)
                }
                HStack(spacing:10){
                    ForEach(character.urls,id: \.self){data in
                        
                        NavigationLink(
                            destination: WebView(url: extractURL(data: data))
                                .navigationTitle(extractURLType(data: data)),
                            label:{
                                
                                Text(extractURLType(data: data))
                            })
                    }
                }
            })
            Spacer(minLength: 0)
            
        }
        .padding(.horizontal)
    }
    
    func extracImage (data: [String: String])-> URL{
        
        let path = data["path"] ?? ""
        let ext = data["extension"] ?? ""
        
        return URL(string: "\(path).\(ext)")!
    }
    
    func extractURL(data : [String:String])->URL{
        let url = data["url"] ?? " "
        return URL(string: url)!
    }
    
    func extractURLType(data: [String:String])->String{
        let type = data["type"] ?? " "
        return type.capitalized
    }
}
