import SwiftUI
import AVFoundation

// MARK: - Track Model
struct Track: Identifiable {
    let id = UUID()
    let title: String
    let artist: String
    let artist2: String
    let imageName: String
    let galleryImages: [String]
    let galleryTitle: [String]
    let songFile: String
    let About: String
    let About2: String
    
}
    
    let tracks = [
        Track(title: "Born to Be",
              artist: "Feat. BOL4",
              artist2: "To My Youth - BOL4",
              imageName: "Born",
              galleryImages: ["Born1", "Born3", "Born2"],
              galleryTitle: ["4 Months", "3 Years old", "12 Years Old"],
              songFile: "ToMyYouth.mp3",
              About: "A nostalgic tribute to Felicia’s hometown of Makassar, reflecting how her roots shaped her dreams and identity.",
              About2: "From the bustling streets of Makassar to the warm embrace of family, Felicia's roots are deeply anchored in her hometown. This song celebrates the unique blend of culture and personality she carries — a city that birthed her dreams and fueled her drive. The rhythm is a mix of energy and nostalgia, like the vibrant markets and rain-soaked afternoons that shaped who she is. With a heart full of hope and a head full of aspirations, this track is the anthem of someone who will always carry her beginnings with her, no matter where she goes."),
        
        Track(title: "The City of Heroes",
              artist: "Feat. Stacey Ryan",
              artist2: "Fall In Love Alone - Stacey Ryan",
              imageName: "City",
              galleryImages: ["City1", "City2", "City3"],
              galleryTitle: ["Fikomrade's Day", "Me Myself and I", "\"1922\""],
              songFile: "FallInLoveAlone.mp3",
              About: "Chronicles her shift from law to communication, embracing unexpected changes and personal growth.",
              About2: "Life has a funny way of changing course, and for Felicia, that meant pivoting from a law degree to finding her true calling in the world of communication. This song is a journey of self-discovery, of breaking free from the expectations that once seemed like her destiny. With a playful beat and a hint of rebellion, it’s the sound of embracing unexpected paths and finding joy in the unknown. A celebration of growth, change, and the boldness it takes to redefine your future."),
        
        Track(title: "Kodaks and Fujifilms",
              artist: "Feat. MAX",
              artist2: "IT'S YOU - MAX",
              imageName: "Kodaks",
              galleryImages: ["Kodak1", "Kodak2", "Kodak3"],
              galleryTitle: ["Retreat", "First Film Production", "Mirror Selfie"],
              songFile: "ItsYou.mp3",
              About: "Celebrates Felicia’s love for costume design in storytelling, highlighting fashion's power in film.",
              About2: "Behind every captivating film is more than just a script or camera angles — it’s the wardrobe that brings the characters to life. This song is Felicia’s love letter to the power of costume design in storytelling. It’s the upbeat, fashion-forward jam that makes you think of those key moments in movies where a single outfit says more than words ever could. With energetic beats and a playful flair, it’s a reminder that sometimes, the right outfit makes all the difference in how we see ourselves and others."),
        
        Track(title: "Java Chip",
              artist: "Feat. NIKI",
              artist2: "Vintage - NIKI",
              imageName: "Friends",
              galleryImages: ["Friends1", "Friend2", "Friends3"],
              galleryTitle: ["Christmas Dinner 2024", "Dezzerttt", "Oweek 2023"],
              songFile: "Vintage.mp3",
              About: "Captures quiet, meaningful moments and conversations, wrapped in a cozy, reflective vibe.",
              About2: "Whether it’s strolling around the city with a cup of Java Chip in hand or diving into late-night conversations about life, love, and everything in between, this track captures the essence of Felicia’s favorite moments. The melody flows like an easy-going chat with a close friend, heartfelt and easy to listen to, with each word leaving a lasting impression. It's the perfect song to accompany those quiet moments where you reflect on life’s big questions — and maybe snack on something sweet along the way."),
        
        Track(title: "The Man Above",
              artist: "Feat. Elevation Worship",
              artist2: "Trust In God - Elevation Worship",
              imageName: "Faith",
              galleryImages: ["Faith1", "Faith2", "Faith3"],
              galleryTitle: ["Worship Leader", "Welcome Home", "Christmas"],
              songFile: "TrustInGod.mp3",
              About: "Expresses her strong faith and commitment to living with purpose, inspired by Colossians 3:23",
              About2: "Faith runs deep for Felicia, and this track is all about finding strength in her belief and her purpose. Inspired by the verse from Colossians 3:23, this song is a declaration of living with intention, giving your best, and always putting your heart into everything you do. With a gentle yet empowering rhythm, it’s the soundtrack to Felicia’s life motto: work for something bigger than yourself and do it with joy."),
        
        Track(title: "Overthinker's Anthem",
              artist: "Feat. Bruno Mars",
              artist2: "To Good Say Goodbye - Bruno Mars",
              imageName: "Over",
              galleryImages: ["Over1", "Over2", "Over3"],
              galleryTitle: ["Monochrome", "Carnival", "Bingsuuuu"],
              songFile: "ToGoodSaYGoodBye.mp3",
              About: "Explores the internal journey of an overthinker, embracing vulnerability and introspection.",
              About2: "Part extrovert, part introvert, Felicia’s mind is always racing with thoughts, feelings, and reflections on everything from casual conversations to deep existential musings. This track is a cathartic release for anyone who spends a little too much time in their head. With a smooth yet reflective melody, it captures that feeling of replaying moments, analyzing every word, and navigating the space between self-doubt and self-assurance. It’s a song for the overthinkers — a reminder that it’s okay to feel all the feels."),
        
        Track(title: "Second Child",
              artist: "Feat. AKMU",
              artist2: "How can I love the heartbreak, you’re the one I love - AKMU",
              imageName: "Sec",
              galleryImages: ["Sec1", "Sec2", "Sec3"],
              galleryTitle: ["With Mum", "Big Bro's Graduation", "Covid"],
              songFile: "AKMU.mp3",
              About: "A heartfelt homage to her mother and brother, honoring the values they instilled in her.",
              About2: "Felicia’s family is her rock, and this track is a tribute to the two people who shaped her life the most: her mother and her brother. With a warm, soulful tune, it’s a celebration of the values they instilled in her — resilience, discipline, faith, and ambition. This song is about being guided by wisdom and love, and it’s the perfect anthem for anyone who’s been blessed with family who builds you up and helps you navigate life’s challenges."),
        
        Track(title: "Dream On",
              artist: "Feat. Red Velvet",
              artist2: "미래 - Red Velvet",
              imageName: "Dream",
              galleryImages: ["Dream1", "Dream2", "Dream3"],
              galleryTitle: ["Faith", "Hobby", "Travel"],
              songFile: "Red.mp3",
              About: "Looks ahead to her dreams of making a difference while building a loving future and family.",
              About2: "Felicia’s future is all about creating and managing meaningful projects, but more than that, she’s dreaming of a life filled with love, connection, and family. This track is an ode to those aspirations, capturing the heart of someone who strives to make a difference in the world while building a loving home. With an optimistic beat and a hopeful tone, it’s about following your dreams, building a legacy, and one day raising a family that reflects all of the love and care she’s put into the world.")
    ]

