import 'package:flutter/material.dart';
import 'package:quote_generator/model/quote.dart';
import 'package:quote_generator/controller/quote_provider.dart';

class QuoteScreen extends StatefulWidget {
  const QuoteScreen({super.key});

  @override
  State<QuoteScreen> createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  final QuoteProvider _quoteProvider = QuoteProvider();
  late Future<List<QuoteModel>> _quoteFuture;
  QuoteModel? _currentQuote;

  @override
  void initState() {
    super.initState();
    _quoteFuture = _quoteProvider.loadQuotes();
  }

  void _getRandQuote() =>
      setState(() => _currentQuote = _quoteProvider.quoteRand);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Random Quote Generator')),
      body: Center(
        child: FutureBuilder<List<QuoteModel>>(
          future: _quoteFuture,
          builder: (context, snapshot) {
            final isLoading = snapshot.connectionState != ConnectionState.done;

            if (snapshot.hasError) return Text('Error: ${snapshot.error}');

            _currentQuote ??= _quoteProvider.quoteRand;

            // _currentQuote = (snapshot.data == null || snapshot.data!.isEmpty)
            //     ? null
            //     : QuoteModel(text: 'No quote available..');

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 16,
              children: [
                AnimatedSwitcher(
                  duration: Duration(milliseconds: 400),
                  child: QuoteView(_currentQuote, key: ValueKey(_currentQuote)),
                ),
                ElevatedButton.icon(
                  onPressed: _getRandQuote,
                  label: const Text('Random Quote'),
                  icon: isLoading ? Icon(Icons.replay_outlined) : null,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

/// shows loading widget when [quote] is null
class QuoteView extends StatelessWidget {
  const QuoteView(
    this.quote, {
    super.key,
  });
  final QuoteModel? quote;

  @override
  Widget build(BuildContext context) {
    final isLoading = quote == null;
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadiusGeometry.directional(
          topEnd: Radius.circular(16),
          bottomEnd: Radius.circular(16),
          bottomStart: Radius.circular(16),
        ),
        border: BoxBorder.all(
          width: 1.5,
          color: Colors.grey.withValues(alpha: .7),
        ),
      ),
      child: Column(
        spacing: 12,
        children: isLoading
            ? [
                CircularProgressIndicator(),
              ]
            : [
                Text(quote!.text),
                Text(
                  'by ${quote!.author}',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ],
      ),
    );
  }
}
