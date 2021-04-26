import 'dart:convert';
import 'package:gomlgy/models/history_model.dart';
import 'package:http/http.dart' as http;
import '../helpers/http_exception.dart';
import '../helpers/base_url.dart' as baseurl;

class OrderDetailsProvider {
  Future<List> fetchHistoryDetails(String detailsUrl) async {
    var url = detailsUrl;

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: Map<String, String>.from({
          'Content-Type': 'application/json;charset=UTF-8',
          'Charset': 'utf-8',
          'Authorization':
              'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjMyZmFkYjhiZjAyNTAyZmQzMzY2NWNmOWQ5NzRjYzMyNGE2NThmMDljYmM1MDdiYTk5ODJjODM1YjU5YmI4YzMxMTY1MWUyNmIzNGM2OTJmIn0.eyJhdWQiOiIzIiwianRpIjoiMzJmYWRiOGJmMDI1MDJmZDMzNjY1Y2Y5ZDk3NGNjMzI0YTY1OGYwOWNiYzUwN2JhOTk4MmM4MzViNTliYjhjMzExNjUxZTI2YjM0YzY5MmYiLCJpYXQiOjE2MTc3MDY4MTIsIm5iZiI6MTYxNzcwNjgxMiwiZXhwIjoxNjQ5MjQyODEyLCJzdWIiOiIxNjMiLCJzY29wZXMiOltdfQ.mccdVavA4r5OJxbTHZRelFzHsrVeU_6GbJd3RR_4fOBM1a8VvP-jTa2F0QRpPqAKsyVgV-hluULSajchChCPwXPaGWsWTyBReCOk5ugEi_5T0vuGXWkCDKEcAAdQc_WBwJXbCRamfbAuYG_5NP81urZXpYWM5p9WZJ7JahiS3js8fgWfHvYu_yCBHZ10SAtU56V_ujLSFOkhMWcQCi8IjPFlKQzoqNSNy2iMgXwACQjKDzi31jd46toWh9dv4DSZSwcaoyyW0ziNpJojFM2Vy207F7ofzYGAHbiinGeZq_RH6898hOAeDSFaYFGAqP5-GM87TCniKEZiIH9d2ul45YEvT7m4nJ2FksS3nnMnkT88bkQyONuOGWJzsNlnsPVzCH1xxmy0KMUXItOYdncfr0PqpZz9bFjjRNemUmm0SRVqxDR7CIJHk9cxUyet7VmgQRxJesZOM2L2rh4O-T9OKz4pAMjyT1jeRDzWcVfwH3xnnMr-kt6ohUYlUtrCHfLQZUaoWTfmaEgFKOaHQ4JgvFemnKhLtmzko4Yi9svyYNrE-U3gZsR_Lbp9vNjrx57v83DGnKSUeV0e7PXKSuSt87qIBnOLapNeocrWZlDgT1inIBSHF8s0mSqu17JkgQg_u-YA5wYagSa4hVdbSjk32B_WWMC7zJQQ2hseacNKOqc'
        }),
      );

      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      // print(response.body);
      if (response.statusCode >= 400) {
        print('mohamed***' + response.body);
        throw HttpException('An error occurred');
      }
      if (extractedData == null) {
        return [];
      }

      var data = (extractedData['data'] as List).map((data) {
        final extractedData = data as Map<String, dynamic>;

        return HistoryDetails(
          product: extractedData['product'].toString(),
          tax: double.parse(extractedData['tax'] != null
              ? extractedData['tax'].toString()
              : '0'),
          price: double.parse(extractedData['price'] != null
              ? extractedData['price'].toString()
              : '0'),
          shipping_cost: double.parse(extractedData['shipping_cost'] != null
              ? extractedData['shipping_cost'].toString()
              : '0'),
          payment_type: extractedData['payment_status'].toString(),
          coupon_discount: double.parse(extractedData['coupon_discount'] != null
              ? extractedData['coupon_discount'].toString()
              : '0'),
          quantity: extractedData['quantity'],
        );
      }).toList();
      print('data:' + data.length.toString());
      return data;
    } catch (e) {
      print(e);
      throw HttpException('An error occurred');
    }
  }
}
