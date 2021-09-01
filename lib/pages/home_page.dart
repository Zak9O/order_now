import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:order_now/constants.dart';
import 'package:order_now/widgets/elevated_card.dart';
import 'package:order_now/widgets/rounded_text_field.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, box) => Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 1000),
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
            children: [
              _AccountCard(),
              SizedBox(
                height: 30.0,
              ),
              SizedBox(
                height: 250.0,
                child: _UsageCard(),
              ),
              SizedBox(
                height: 25.0,
              ),
              SizedBox(
                height: 250.0,
                child: _PaymentCard(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget createView(BuildContext context) {
    return LayoutBuilder(builder: (context, box) {
      if (box.maxWidth > 1000) {
        return _WideView();
      }
      return _NarrowView();
    });
  }
}

class _NarrowView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [],
    );
  }
}

class _WideView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: 250.0,
          child: Row(
            children: [
              Expanded(child: _AccountCard()),
              SizedBox(
                width: 25.0,
              ),
              Expanded(child: _UsageCard()),
            ],
          ),
        ),
        SizedBox(
          height: 25.0,
        ),
        _PaymentCard(),
      ],
    );
  }
}

class _AccountCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Account Info',
                style: kTitleTextStyle,
              ),
            ],
          ),
          SizedBox(
            height: 25.0,
          ),
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            children: [
              Text(
                'Company name',
                style: kLesserTitleTextStyle.copyWith(fontSize: 17.0),
              ),
              Text(
                'My Burger Joint',
                style: TextStyle(fontSize: 17.0),
              ),
            ],
          ),
          SizedBox(
            height: 25.0,
          ),
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            children: [
              Text(
                'Email Address',
                style: kLesserTitleTextStyle.copyWith(fontSize: 17.0),
              ),
              Text(
                FirebaseAuth.instance.currentUser.email,
                style: TextStyle(fontSize: 17.0),
              ),
            ],
          ),
          SizedBox(
            height: 25.0,
          ),
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            children: [
              SelectableText(
                'Password',
                style: kLesserTitleTextStyle.copyWith(fontSize: 17.0),
              ),
              SelectableText(
                'Change',
                style: TextStyle(fontSize: 17.0),
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _UsageCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Usage',
            style: kTitleTextStyle,
            textAlign: TextAlign.center,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Sections',
                style: kLesserTitleTextStyle,
              ),
              Text(
                '10',
                style: kLesserTitleTextStyle.copyWith(color: Colors.black),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tables',
                style: kLesserTitleTextStyle,
              ),
              Text(
                '49',
                style: kLesserTitleTextStyle.copyWith(color: Colors.black),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total messages received',
                style: kLesserTitleTextStyle,
              ),
              Text(
                '10928',
                style: kLesserTitleTextStyle.copyWith(color: Colors.black),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PaymentCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedCard(
      child: Text(
        'Payment details',
        style: kTitleTextStyle,
      ),
    );
  }
}
