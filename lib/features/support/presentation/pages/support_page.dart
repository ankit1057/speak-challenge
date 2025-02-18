import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/layouts/main_layout.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'Help & Support',
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              context,
              'Frequently Asked Questions',
              [
                _buildFaqItem(
                  'How do I create a new complaint?',
                  'To create a new complaint, go to the home page and click on the "+" button. '
                  'Select the organization and category, then fill in the details of your complaint.',
                ),
                _buildFaqItem(
                  'How can I track my complaint status?',
                  'You can track your complaint status by going to the History page. '
                  'Each complaint will show its current status and timeline of updates.',
                ),
                _buildFaqItem(
                  'What documents can I attach to my complaint?',
                  'You can attach images, PDFs, and other document types that help support your complaint. '
                  'The maximum file size for each attachment is 10MB.',
                ),
              ],
            ),
            const SizedBox(height: 32),
            _buildSection(
              context,
              'Contact Us',
              [
                _buildContactItem(
                  context,
                  FontAwesomeIcons.envelope,
                  'Email Support',
                  'support@speakup.com',
                  () {/* Handle email */},
                ),
                _buildContactItem(
                  context,
                  FontAwesomeIcons.phone,
                  'Phone Support',
                  '+1 234 567 8900',
                  () {/* Handle phone call */},
                ),
                _buildContactItem(
                  context,
                  FontAwesomeIcons.comments,
                  'Live Chat',
                  'Available 24/7',
                  () {/* Handle live chat */},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context,
    String title,
    List<Widget> children,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 16),
        ...children,
      ],
    );
  }

  Widget _buildFaqItem(String question, String answer) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ExpansionTile(
        title: Text(question),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(answer),
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
          child: FaIcon(
            icon,
            color: Theme.of(context).primaryColor,
            size: 20,
          ),
        ),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const FaIcon(FontAwesomeIcons.angleRight),
        onTap: onTap,
      ),
    );
  }
} 