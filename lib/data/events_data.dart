import '../models/events.dart';
//
class EventsData {
  static List<Event> getEvents() {
    return [
      Event(
        name: 'Biska Jatra',
        description: 'Biska Jatra is a vibrant festival celebrated in Bhaktapur, marking the Nepali New Year. Lasting about nine days.',
        image: 'assets/images/Bisket_Jatra_VIbes.jpg',
      ),
      Event(
        name: 'Gai Jatra',
        description: 'Gai Jatra blends themes of mourning, remembrance and humor, reflecting the rich cultural and emotional fabric of Nepali society.',
        image: 'assets/images/gaijatra.png',
      ),
      Event(
        name: 'Indra Jatra',
        description: 'Indra Jatra is celebrated with the procession of the living goddess Kumari and rituals honoring Indra, the rain god.',
        image: 'assets/images/indrajatra.png',
      ),
      Event(
        name: 'Sindur Jatra',
        description: 'Marked by chariot processions and the throwing of sindur (vermillion powder), it symbolizes unity and celebration.',
        image: 'assets/images/sindur.png',
      ),
    ];
  }
}
//
// class EventsData {
//   static List<Event> getEvents() {
//     return [
//       Event(
//         name: 'Indra Jatra',
//         description: 'One of the biggest festivals of Kathmandu...',
//         image: 'assets/images/indra_jatra.jpg',
//
//       ),
//       // Add more events...
//     ];
//   }
// }