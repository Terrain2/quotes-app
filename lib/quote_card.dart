import "package:flutter/material.dart";
import "package:auto_size_text/auto_size_text.dart";
import "quote.dart";

class QuoteCard extends StatelessWidget {

  final Quote quote;
  final Function delete;
  QuoteCard(this.quote, {this.delete});

  @override
  Widget build(BuildContext context) => Card(
    margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                "\u201C",
                style: TextStyle(
                  fontFamily: 'Noto Serif',
                  fontSize: 30,
                ),
              ),
              Expanded(child: Center(child: CustomText(
                quote.text,
                textStyle: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[700],
                ),
                maxLines: 2,
              ))),
              Text(
                "\u201D",
                style: TextStyle(
                  fontFamily: 'Noto Serif',
                  fontSize: 30,
                ),
              ),
              IconButton(
                onPressed: delete,
                icon: Icon(
                  Icons.close,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          Container(
            alignment: Alignment.bottomRight,
            child: Text(
              quote.author,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

class CustomText extends StatelessWidget {  // Try to fit everything on 1 line, but if not, fallback to 2, then fallback to 3, etc

  final String text;
  final int maxLines;
  final int currentLines;
  final TextStyle textStyle;

  CustomText(this.text, {this.textStyle, this.maxLines, this.currentLines = 1});

  @override
  Widget build(BuildContext context) => AutoSizeText(
    text,
    style: textStyle,
    stepGranularity: 1,
    maxLines: currentLines < maxLines ? currentLines : maxLines,
    overflowReplacement: currentLines < maxLines ? CustomText(
      text,
      textStyle: textStyle,
      maxLines: maxLines,
      currentLines: currentLines + 1,
    ) : null,
    overflow: currentLines < maxLines ? null : TextOverflow.fade,
  );
}
