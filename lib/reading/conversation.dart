import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
class Conversation extends StatefulWidget {
  @override
  _ConversationState createState() => _ConversationState();
}

class _ConversationState extends State<Conversation> {
  late List<String> germanConversations;

  @override
  void initState() {
    super.initState();
    var box = Hive.box("LocalDB");
    final n = box.get("current_lang");
    final lang = box.get("Lang")[n.toString()]["Selected_lang"];

    // Load German conversation phrases
    if (lang[0] == 'German') {
      germanConversations = [
        "Guten Tag!",
        "Wie geht es Ihnen?",
        "Mir geht es gut, danke!",
        "Woher kommen Sie?",
        "Ich komme aus Deutschland.",
        "Was machen Sie beruflich?",
        "Ich bin Student.",
        "Wie alt sind Sie?",
        "Ich bin 30 Jahre alt.",
        "Was sind Ihre Hobbys?",
        "Ich lese gerne und spiele Fußball.",
        "Haben Sie Geschwister?",
        "Ja, ich habe eine Schwester.",
        "Wie ist das Wetter heute?",
        "Es ist sonnig und warm.",
        "Was möchten Sie trinken?",
        "Ich möchte gerne Wasser."
      ];
    } else if (lang[0] == 'French') {
      // Populate sentences with French content
      germanConversations =  [
        "Bonjour!",
        "Comment ça va?",
        "Ça va bien, merci!",
        "D'où venez-vous?",
        "Je viens de France.",
        "Que faites-vous dans la vie?",
        "Je suis étudiant.",
        "Quel âge avez-vous?",
        "J'ai 30 ans.",
        "Quels sont vos hobbies?",
        "J'aime lire et jouer au football.",
        "Avez-vous des frères et sœurs?",
        "Oui, j'ai un frère.",
        "Quel temps fait-il aujourd'hui?",
        "Il fait soleil et chaud.",
        "Que voulez-vous boire?",
        "Je voudrais de l'eau, s'il vous plaît."
      ];
    } else if(lang[0]=='Russian'){
      germanConversations =[
        "Здравствуйте!",
        "Как дела?",
        "Хорошо, спасибо!",
        "Откуда вы?",
        "Я из России.",
        "Кем вы работаете?",
        "Я студент.",
        "Сколько вам лет?",
        "Мне 30 лет.",
        "Какие у вас хобби?",
        "Я люблю читать и играть в футбол.",
        "У вас есть братья или сестры?",
        "Да, у меня есть брат.",
        "Какая сегодня погода?",
        "Сегодня солнечно и тепло.",
        "Что вы хотите выпить?",
        "Я бы хотел воду, пожалуйста."
      ];
    }
    else if(lang[0]=='Japanese'){
      germanConversations =[
        "こんにちは！",
        "お元気ですか？",
        "はい、元気です！",
        "出身はどこですか？",
        "私は日本から来ました。",
        "仕事は何をしていますか？",
        "私は学生です。",
        "何歳ですか？",
        "私は30歳です。",
        "趣味は何ですか？",
        "読書やサッカーが好きです。",
        "兄弟姉妹はいますか？",
        "はい、兄がいます。",
        "今日の天気はどうですか？",
        "今日は晴れで暖かいです。",
        "何を飲みたいですか？",
        "水をください。"
      ];
    }
    else if(lang[0]=='Korean'){
      germanConversations= [
        "안녕하세요!",
        "어떻게 지내세요?",
        "잘 지내요, 감사합니다!",
        "어디에서 오셨어요?",
        "저는 한국에서 왔어요.",
        "직업이 무엇인가요?",
        "저는 학생입니다.",
        "몇 살이에요?",
        "저는 30살이에요.",
        "취미가 뭐에요?",
        "책 읽기와 축구를 좋아해요.",
        "형제나 자매가 있나요?",
        "네, 형이 있어요.",
        "오늘 날씨는 어떻게 되나요?",
        "오늘은 맑고 따뜻해요.",
        "무엇을 마시고 싶으세요?",
        "물을 마시고 싶어요."
      ];
    }
    else if(lang[0]=='Malayalam'){
      germanConversations= [
        "ഹലോ!",
        "സുഖമാണോ?",
        "സുഖമാണ്, നന്ദി!",
        "എവിടെയാണ് നിങ്ങൾ നിറഞ്ഞിരിക്കുന്നത്?",
        "ഞാൻ ഇന്ത്യയിലാണ്.",
        "നിങ്ങൾ എന്തെങ്കിലും പ്രവർത്തിച്ചേക്കുന്നുണ്ടോ?",
        "ഞാൻ വിദ്യാർത്ഥിയാണ്.",
        "നിങ്ങൾക്ക് എത്രയും പ്രായം ഉണ്ട്?",
        "എനിക്ക് 30 വയസ്സ് ഉണ്ട്.",
        "നിങ്ങൾക്ക് ഏതെങ്കിലും ഹോബികൾ ഉണ്ടോ?",
        "ഞാൻ വായിക്കാൻ ഇഷ്ടമാകുന്നു എന്നിവയാണ്.",
        "നിങ്ങൾക്ക് സഹോദരികളും സഹോദരിമാർ ഉണ്ടോ?",
        "അതെ, എനിക്ക് ഒരു ചേട്ടനുണ്ട്.",
        "ഇന്നത്തെ കാലാവസ്ഥ എങ്ങനെ ആണ്?",
        "ഇന്ന് ചുറ്റും പ്രശാന്തമായിരിക്കുന്നു.",
        "നിങ്ങൾ എന്തിനെയാണ് കുടിക്കാനുള്ള ഉദ്ദേശ്യം?",
        "ദയവായി വെള്ളം കൊടുക്കുക."
      ];
    }
    else if(lang[0]=='Tamil'){
      germanConversations= [
        "வணக்கம்!",
        "நீங்கள் எப்படி இருக்கிறீர்கள்?",
        "நான் நன்றாகவே இருக்கிறேன், நன்றி!",
        "நீங்கள் எங்கே இருந்து வந்தீர்கள்?",
        "நான் இந்தியாவில் இருந்து வந்துள்ளேன்.",
        "உங்கள் பொழுதுபோக்கு என்ன?",
        "நான் படிப்பினையளிக்கும்.",
        "உங்களுக்கு எத்தனை வயது?",
        "எனக்கு 30 வயது.",
        "உங்களுக்கு என்ன ஆரம்பிக்க இஷ்டம்?",
        "நான் புத்தகம் படிப்பது மற்றும் கால்பந்து விளையாடுவது பிடிக்கும்.",
        "உங்களிடம் சகோதரர் அல்லது சகோதரி உள்ளார்களா?",
        "ஆம், எனக்கு ஒரு சகோதரன் உள்ளார்.",
        "இன்றைய என் மனிதகள் எப்படி உள்ளன?",
        "இன்று மழை பெய்யும்.",
        "நீங்கள் என்னை உட்கார விரும்புகிறீர்களா?",
        "நீர் கொடுக்கவும்."
      ];
    }
    else{
      germanConversations= [
    "आपका काम क्या है?", // What is your job?
    "मैं एक शिक्षक हूँ।", // I am a teacher.
    "आपकी पसंदीदा फिल्म कौन सी है?", // What is your favorite movie?
    "मेरी पसंदीदा फिल्म दिलवाले दुल्हनिया ले जाएंगे है।", // My favorite movie is Dilwale Dulhania Le Jayenge.
    "आपको क्या पसंद है?", // What do you like?
    "मुझे गाने और फिल्में देखना पसंद है।", // I like listening to music and watching movies.
    "आपके पास कितने भाई और बहन हैं?", // How many brothers and sisters do you have?
    "मेरे पास तीन भाई और दो बहन हैं।", // I have three brothers and two sisters.
    "आपकी पसंदीदा खाना क्या है?", // What is your favorite food?
    "मेरा पसंदीदा खाना बिरयानी है।", // My favorite food is biryani.
    ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""
            " conversation"),
      ),
      body: ListView.builder(
        itemCount: germanConversations.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(germanConversations[index]),
          );
        },
      ),
    );
  }
}
