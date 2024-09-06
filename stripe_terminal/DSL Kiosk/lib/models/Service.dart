// class Service {
//   final String id;
//   final String title;
//   final String slug;
//   final String description;
//   final String longDescription;
//   final String tags;
//   final String imageOfTheService;
//   final List<String> otherImages;
//   final List<String> files;
//   final String price;
//   final String discountedPrice;
//   final String numberOfMembersRequired;
//   final String duration;
//   final String rating;
//   final String numberOfRatings;
//   final String maxQuantityAllowed;
//   final String isPayLaterAllowed;
//   final String status;
//   final String createdAt;
//   final String cancelableTill;
//   final String cancelable;
//   final String statusBadge;
//   final String taxId;
//   final List<Faq> faqs;
//   final String taxTitle;
//   final String taxPercentage;
//   final String taxValue;
//   final String priceWithTax;
//   final String originalPriceWithTax;
//   final String statusNumber;
//   final String operations;
//   final String isCancelable;
//
//   Service({
//     required this.id,
//     required this.title,
//     required this.slug,
//     required this.description,
//     required this.longDescription,
//     required this.tags,
//     required this.imageOfTheService,
//     required this.otherImages,
//     required this.files,
//     required this.price,
//     required this.discountedPrice,
//     required this.numberOfMembersRequired,
//     required this.duration,
//     required this.rating,
//     required this.numberOfRatings,
//     required this.maxQuantityAllowed,
//     required this.isPayLaterAllowed,
//     required this.status,
//     required this.createdAt,
//     required this.cancelableTill,
//     required this.cancelable,
//     required this.statusBadge,
//     required this.taxId,
//     required this.faqs,
//     required this.taxTitle,
//     required this.taxPercentage,
//     required this.taxValue,
//     required this.priceWithTax,
//     required this.originalPriceWithTax,
//     required this.statusNumber,
//     required this.operations,
//     required this.isCancelable,
//   });
//
//   factory Service.fromJson(Map<String, dynamic> json) {
//     var otherImages = json['other_images'] as List<dynamic>;
//     var files = json['files'] as List<dynamic>;
//     var faqs = json['faqs'] as List<dynamic>;
//
//     return Service(
//       id: json['id'],
//       title: json['title'],
//       slug: json['slug'],
//       description: json['description'],
//       longDescription: json['long_description'],
//       tags: json['tags'],
//       imageOfTheService: json['image_of_the_service'],
//       otherImages: otherImages.cast<String>(),
//       files: files.cast<String>(),
//       price: json['price'],
//       discountedPrice: json['discounted_price'],
//       numberOfMembersRequired: json['number_of_members_required'],
//       duration: json['duration'],
//       rating: json['rating'],
//       numberOfRatings: json['number_of_ratings'],
//       maxQuantityAllowed: json['max_quantity_allowed'],
//       isPayLaterAllowed: json['is_pay_later_allowed'],
//       status: json['status'],
//       createdAt: json['created_at'],
//       cancelableTill: json['cancelable_till'],
//       cancelable: json['cancelable'],
//       statusBadge: json['status_badge'],
//       taxId: json['tax_id'],
//       faqs: faqs.map((faq) => Faq.fromJson(faq)).toList(),
//       taxTitle: json['tax_title'],
//       taxPercentage: json['tax_percentage'],
//       taxValue: json['tax_value'],
//       priceWithTax: json['price_with_tax'],
//       originalPriceWithTax: json['original_price_with_tax'],
//       statusNumber: json['status_number'],
//       operations: json['operations'],
//       isCancelable: json['is_cancelable'],
//     );
//   }
//
//   // Static list of example data
//   static final List<Service> exampleList = [
//     Service(
//       id: '1',
//       title: 'AC Repair Service',
//       slug: 'ac-repair',
//       description: 'Professional AC repair service for all types of air conditioners.',
//       longDescription: 'Our expert technicians provide fast and reliable AC repair services. We cover all brands and models of air conditioners.',
//       tags: 'AC, Repair, Service',
//       imageOfTheService: 'https://example.com/images/ac_repair.jpg',
//       otherImages: [
//         'https://example.com/images/ac_repair_1.jpg',
//         'https://example.com/images/ac_repair_2.jpg',
//       ],
//       files: [
//         'https://example.com/files/repair_guide.pdf',
//         'https://example.com/files/service_terms.pdf',
//       ],
//       price: '100',
//       discountedPrice: '80',
//       numberOfMembersRequired: '1',
//       duration: '2 hours',
//       rating: '4.5',
//       numberOfRatings: '150',
//       maxQuantityAllowed: '10',
//       isPayLaterAllowed: 'Yes',
//       status: 'Active',
//       createdAt: '2024-07-31T12:00:00Z',
//       cancelableTill: '2024-08-01T12:00:00Z',
//       cancelable: 'Yes',
//       statusBadge: 'New',
//       taxId: 'TAX123456',
//       faqs: [
//         Faq(question: 'What is included in the service?', answer: 'The service includes diagnosis, repair, and testing of the AC unit.'),
//         Faq(question: 'What brands do you service?', answer: 'We service all major brands of air conditioners.'),
//       ],
//       taxTitle: 'Service Tax',
//       taxPercentage: '10%',
//       taxValue: '10',
//       priceWithTax: '110',
//       originalPriceWithTax: '120',
//       statusNumber: '1',
//       operations: 'Repair',
//       isCancelable: 'Yes',
//     ),
//     Service(
//       id: '2',
//       title: 'Pest Control Service',
//       slug: 'pest-control',
//       description: 'Effective pest control solutions for your home and office.',
//       longDescription: 'Our pest control service is designed to eliminate pests quickly and safely. We use eco-friendly products to ensure a safe environment.',
//       tags: 'Pest, Control, Service',
//       imageOfTheService: 'https://example.com/images/pest_control.jpg',
//       otherImages: [
//         'https://example.com/images/pest_control_1.jpg',
//         'https://example.com/images/pest_control_2.jpg',
//       ],
//       files: [
//         'https://example.com/files/pest_control_guide.pdf',
//         'https://example.com/files/service_terms.pdf',
//       ],
//       price: '150',
//       discountedPrice: '120',
//       numberOfMembersRequired: '1',
//       duration: '3 hours',
//       rating: '4.8',
//       numberOfRatings: '200',
//       maxQuantityAllowed: '5',
//       isPayLaterAllowed: 'No',
//       status: 'Active',
//       createdAt: '2024-07-31T12:00:00Z',
//       cancelableTill: '2024-08-02T12:00:00Z',
//       cancelable: 'Yes',
//       statusBadge: 'Featured',
//       taxId: 'TAX789012',
//       faqs: [
//         Faq(question: 'How long does the treatment last?', answer: 'The treatment usually lasts for up to 6 months.'),
//         Faq(question: 'Is the treatment safe for pets?', answer: 'Yes, our treatments are safe for pets once they have dried.'),
//       ],
//       taxTitle: 'Service Tax',
//       taxPercentage: '10%',
//       taxValue: '15',
//       priceWithTax: '165',
//       originalPriceWithTax: '175',
//       statusNumber: '2',
//       operations: 'Control',
//       isCancelable: 'Yes',
//     ),
//   ];
// }
//
// class Faq {
//   final String question;
//   final String answer;
//
//   Faq({
//     required this.question,
//     required this.answer,
//   });
//
//   factory Faq.fromJson(Map<String, dynamic> json) {
//     return Faq(
//       question: json['question'],
//       answer: json['answer'],
//     );
//   }
// }

//
// class Service {
//   final int id;
//   final String title;
//   final String description;
//   final String longDescription;
//   final double price;
//   final double discountedPrice;
//   final int numberOfMembersRequired;
//   final int duration;
//   final String rating;
//   final String numberOfRatings;
//
//   Service({
//     required this.id,
//     required this.title,
//     required this.description,
//     required this.longDescription,
//     required this.price,
//     required this.discountedPrice,
//     required this.numberOfMembersRequired,
//     required this.duration,
//     required this.rating,
//     required this.numberOfRatings,
//   });
//
//   factory Service.fromJson(Map<String, dynamic> json) {
//     return Service(
//       id: json['id'],
//       title: json['title'],
//       description: json['description'],
//       longDescription: json['long_description'],
//       price: json['price'].toDouble(),
//       discountedPrice: json['discounted_price'].toDouble(),
//       numberOfMembersRequired: json['number_of_members_required'],
//       duration: json['duration'],
//       rating: json['rating'],
//       numberOfRatings: json['number_of_ratings'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'title': title,
//       'description': description,
//       'long_description': longDescription,
//       'price': price,
//       'discounted_price': discountedPrice,
//       'number_of_members_required': numberOfMembersRequired,
//       'duration': duration,
//       'rating': rating,
//       'number_of_ratings': numberOfRatings,
//     };
//   }
// }
class Service {
  final int id;
  final String title;
  final String description;
  final String longDescription;
  final double price;
  final double discountedPrice;
  final int duration;
  final String rating;
  final String numberOfRatings;

  Service({
    required this.id,
    required this.title,
    required this.description,
    required this.longDescription,
    required this.price,
    required this.discountedPrice,
    required this.duration,
    required this.rating,
    required this.numberOfRatings,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'] is int ? json['id'] : int.parse(json['id'].toString()),
      title: json['title'],
      description: json['description'],
      longDescription: json['long_description'],
      price: json['price'] is double ? json['price'] : double.parse(json['price'].toString()),
      discountedPrice: json['discounted_price'] is double ? json['discounted_price'] : double.parse(json['discounted_price'].toString()),
      duration: json['duration'] is int ? json['duration'] : int.parse(json['duration'].toString()),
      rating: json['rating'].toString(),
      numberOfRatings: json['number_of_ratings'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'long_description': longDescription,
      'price': price,
      'discounted_price': discountedPrice,
      'duration': duration,
      'rating': rating,
      'number_of_ratings': numberOfRatings,
    };
  }
}
