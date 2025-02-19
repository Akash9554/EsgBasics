
import 'package:flutter/material.dart';

class InformationPagess extends StatefulWidget {
  final VoidCallback onAccept;
  const InformationPagess({super.key, required this.onAccept});
  @override
  _InformationPagesState createState() => _InformationPagesState();
}

class _InformationPagesState extends State<InformationPagess> {

  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, dynamic>> sections = [
    {
      'heading': 'Company Certification',
      'text': [
        ' MUST AGREE to for compliance',
        '1. Are you willing to accept both announced and unannounced audits of your premises, including subcontracted premises, and provide any information related to ESG Standards upon request by the certification body?',
        '2. Have you appointed a contact person for all certification ma'
            'tters who will keep the certification body updated with contact details and important information related to certification?',
        '3. Can you demonstrate that your organization is established by providing legal registration documents and records confirming your legal business status?',
        '4. Can you demonstrate that there is ESG market potential for your product?',
        '5. Did a majority of management or owners make the decision to join ESG through a democratic and informed process?',
        '6. Are you free of indications that you or your employees violate national legislation on topics covered by the standards set forth by ESG “The Guild”?',
        '7. If there are indications of conflicts regarding your employees legal and legitimate right to land, water use, and land tenure, have these been resolved responsibly and transparently?',
        '8. Are you free of indications that you or your employees take actions to evade the ESG Standards?',
      ],
    },
    {
      'heading': 'Traceability',
      'text': [
        ' MUST AGREE to for compliance',
        '1. Do you ensure that products sourced from your farm/company and sold as ESG have been physically segregating at all stages until sold?',
        '2. Do you document the flow of products from your farm/company to the first buyer accurately?',
        '3. When selling an ESG product, do you clearly identify in the related documents, such as invoices and delivery notes, that the product is sourced and traded on ESG terms?',
        '4. Do you keep records of all your ESG sales, including information like volume sold, buyers name and certification ID number, date of the transaction, and references to sales documents to allow certification bodies to link these records?',
        '5. If you process ESG products, do you keep records specifying the amount of product before and after processing?',
        '6. When selling an ESG product, do you mark the product clearly to identify it as an ESG product?',
        '7. Do you comply with traceability rules at the processing stage, ensuring that volumes sold as ESG do not exceed those produced by your farm/company, that the product is produced by your farm/company before being sold, and that the product from your farm/company is delivered and processed on the same site where the ESG product is processed?',
      ],
    },
    {
      'heading': 'Contracts',
      'text': [
        ' MUST AGREE to for compliance',
        '1. Do you sign binding purchase contracts provided by your buyers, which are in line with ESG requirements?',
        '2. Do you refrain from signing new ESG contracts if your buyer or you are suspended?',
        '3. If you or your first ESG buyer is decertified, do you stop selling any ESG products from the date of decertification, even if you have signed ESG contracts still to be fulfilled?',
      ],
    },
    {
      'heading': 'Use of ESG Marks',
      'text': [
        ' MUST AGREE to for compliance',
        '1. If you want to use any of the ESG Marks on your wholesale packaging or external promotional material, will you first contact ESG for approval at artwork@ESGFashions.org?',
        '2. If you produce finished ESG products and want to sell them to consumers under your own brand name with any ESG Marks, will you sign a contract with ESG?',
      ],
    },
    {
      'heading': 'Production intent',
      'text': [
        ' MUST AGREE to for compliance',
        '1. Do you inform your suppliers about the environmental and labor requirements outlined in the Production section of the ESG Standard?',
        '2. Have you identified the risks associated with non-compliance of the production section requirements by you or your suppliers?',
        '3. Will you periodically update your risk assessments at least every 3 years to ensure ongoing compliance with the Production section?',
        '4. Have you defined and implemented a procedure for monitoring and assessing the performance and compliance of your suppliers?',
        '5. Do you have an Internal Management System (IMS) in place that enables you to monitor and assess compliance with ESG requirements at all levels of the organization?',

      ],
    },
    {
      'heading': 'Environmental Development ',
      'text': [
        ' MUST AGREE to for compliance',
        '1. Do you and your employees follow agricultural and environmental practices that contribute to a more sustainable production system?',
        '2. Is a person designated in your organization to lead the operational steps for complying with environmental development requirements?',
        '3. Do you provide training on integrated pest management to your employees?',
        '4. Can your employees demonstrate that pesticides are applied based on knowledge of pests and diseases?',
        '5. Do you offer training to employees and workers on the safe handling of hazardous materials?',
        '6. Do you ensure that all individuals, including employees and workers, wear appropriate personal protective equipment when handling pesticides or hazardous chemicals?',
        '7. Do you raise awareness among all employees and workers about the hazards and risks related to pesticides and other hazardous chemicals?',
        '8. Do you and your employees refrain from applying pesticides and other hazardous chemicals within 10 meters of ongoing human activity?',
        '9. If pesticides or hazardous chemicals are sprayed from the air, do you and your employees avoid spraying above and around places with ongoing human activity or above and around water sources?',
        '10. Do you maintain a central storage area for pesticides and other hazardous chemicals in a way that minimizes risks?',
        '11. Do your employees store pesticides and other hazardous chemicals in a way that minimizes risks, ensuring they cannot be reached by children?',
        '12. Do your employees have all pesticides and hazardous chemicals clearly labelled?',
        '13. Do your employees plan spraying activities to minimize leftover spray solution and have equipment to handle accidents and spills, preventing contamination of soil or water?'
        '14. Do you and your employees ensure that containers used for pesticides and other hazardous chemicals are not reused to store or transport food or water? ',
        '15. Do you and your employees triple rinse, puncture, and properly store empty pesticide and hazardous chemical containers?',
        '16. Do you compile and keep an updated list of the pesticides used on ESG crops?'
        '17. Do you and your employees refrain from using any of the materials on the ESG Banned Substances List?',
        '18. Is the use of any chemical substances outside the scope of ESG standards not accepted and cannot be appealed within your organization?',
        '19. Have you developed a procedure to ensure that employees do not use any hazardous materials on their ESG crops that are banned or restricted by ESG standards?',
        '20. Do you minimize the amount of herbicides used by employees through other weed prevention and control strategies?',
        '21. Do you identify land at risk of soil erosion and land that is already eroded where your employees plant ESG crops?',
        '22. Do you train employees where there is a risk of soil erosion or already eroded land on practices to reduce or prevent soil erosion?',
        '23. Do you train your employees on the appropriate use of fertilizers?',
        '24. Do your employees implement measures to enhance soil fertility?',
        '25. Do you train your employees on measures to use water efficiently?',
        '26. Do your employees follow practices that improve water resources management?',
        '27. Do you handle waste water from central processing facilities in a manner that does not negatively impact water quality, soil fertility or food safety?',
        '28. Do you train your employees on waste water and the health risks it poses, as well as on the prevention of risks and treatment methods of waste water and their implementation?',
        '29. Do your employees avoid negative impacts on protected areas and areas with high conservation value within or outside the farm or production areas?',
        '30. Do your employees refrain from causing deforestation and from destroying vegetation in carbon storage ecosystems or protected areas?',
        '31. Do you have a procedure in place to prevent your employees from causing deforestation or degrading vegetation?',
        '32. Do you and your employees take measures to protect and enhance biodiversity?',
        '33. Do you and your employees maintain buffer zones around bodies of water, watershed recharge areas, and near areas of high conservation value, avoiding the use of pesticides, hazardous chemicals, and fertilizers in these zones?',
        '34. Do your employees ensure the sustainability and survivability of species when conducting wild harvesting of ESG products from uncultivated areas?',
        '35. Do you raise awareness among your employees to prevent the collecting or hunting of rare or threatened species?',
        '36. Do you inform your employees about the risks of introducing alien invasive species and ensure they do not do so?',
      ],
    },

    {
      'heading': 'Occupational health and safety',
      'text': [
        ' MUST AGREE to for compliance',
        '1. Do you and your employees ensure that all field workers have access to clean drinking water that is available in the region?',
        '2. Do you and your employees make work processes, workplaces, machinery, and equipment on your production site safe?',
        '3. Do you and your employees prevent children under 18, pregnant or nursing women, mentally disabled individuals, and people with chronic illnesses or respiratory diseases from engaging in any potentially hazardous work?',
        '4. Do you and your employees provide clean toilets/latrines with hand-washing facilities nearby for workers, ensuring they are separate for women and men and in proportion to the number of workers?',
        '5. Do you and your employees provide showering or washing facilities for workers who handle pesticides, ensuring they are separate for women and men and in proportion to the number of workers?',
        '6. Do you and your employees provide training to workers on the risks of hazardous work to their health and the environment, and on what to do in case of an accident?',
        '7. When carrying out hazardous work, do you and your employees display all information, safety instructions, re-entry intervals, and hygiene recommendations clearly and visibly in the workplace in the local language(s) and with pictograms?',
        '8. Do you and your employees provide and pay for personal protective equipment (PPE) for all workers who perform hazardous work? ',
        '9. Do you and your employees ensure that workers nominate a representative who knows about health and safety issues and who will raise workers’ concerns on health and safety issues with the organization’s management by Year 3?',
        '10. Do you and your employees improve health and safety conditions by putting up warning signs that identify risk areas and potential hazards in local languages, and including pictograms if possible?',
        '11. Do you and your employees provide information to workers about safety instructions and procedures, including accident prevention and response?',
        '12. Do you and your employees put safety devices on all hazardous machinery and equipment and protective guards over moving parts?',
        '13. Do you and your employees provide safety equipment to all workers who perform hazardous tasks and instruct and monitor workers on its proper use?'
      ],
    },
    {
      'heading': 'Continuous Improvement Program (CIP) - Above and Beyond',
      'text': [
        '*Non-Binding Agreement to Implement CIP*',
        'We, the undersigned farmers, express our intent to try to implement the Continuous Improvement Plan (CIP) to the best of our abilities, contingent on available resources and capabilities. This statement signifies our commitment to consider and pursue the goals of the CIP where feasible, without obligating ourselves to any legal or financial responsibility.',
        '**Sustainable Practices**:'
            '- Do you implement regenerative agriculture practices to enhance soil health and biodiversity?',
        '**Water Usage**:'
            '- Do you use advanced irrigation systems to minimize water waste and enhance efficiency?',
        '**Energy Use**:'
        '- Are renewable energy sources (solar, wind) used for farm operations to reduce carbon footprint?',
        '**Chemical Use**:'
            '- Do you use organic or bio-pesticides to minimize environmental and health risks?',
        '**Waste Management**:'
            '- Is there a zero-waste policy to ensure all by-products are recycled or repurposed?',
        '**Education and Training**:'
        '- Is ongoing education and skills training provided to workers for their professional development?',
        '**Worker Participation**:'
            '- Are workers involved in decision-making processes related to farm operations and policies?',
        '**Health Benefits**:'
         '- Do you provide comprehensive health benefits and regular health check-ups for all workers?',
        '**Living Conditions**:'
         '- Are housing accommodations provided, ensuring a safe and comfortable living environment for workers?',
        '**Equality Initiatives**: '
            '- Are there specific programs to support the advancement and empowerment of women in the workforce?',
        '**Profit-Sharing**:'
            '- Do you have a profit-sharing scheme that ensures workers receive a share of the farm’s profits?',
        '**Childcare Provision**:'
            '- Is on-site childcare provided to support working parents?',
        '**Life Insurance**:'
        '- Do you offer life insurance policies for workers to secure their families futures?',
        '**Cultural Sensitivity**:'
            '- Are cultural traditions and practices of workers respected and integrated into their work environment?',
        '**Worker Feedback**:'
         '- Is there an anonymous feedback system for workers to share their suggestions and concerns?',
        '**Health and Wellness Programs**:'
            '- Are wellness programs (yoga, counseling) available to improve workers mental and physical health?',
        '**Disaster Preparedness**:'
            '- Do you have comprehensive disaster preparedness and emergency response plans in place?',
        '**Climate Action**:'
            '- Do you participate in initiatives and research aimed at combating climate change?',
        '**Work-Life Balance**:  '
            '- Do you offer flexible working hours to accommodate workers personal needs and family obligations?',
        '**Fair Wages**:  - Are wages periodically reviewed and raised to match or exceed living wage standards?',
        '**Safe Working Conditions**:  - Do you provide protective gear and ensure all safety protocols are regularly updated and strictly enforced?',
        '**Nutritious Meals**:  - Are free or subsidized nutritious meals provided during work hours?',
        '**Rest and Leisure**:  - Do you provide adequate rest breaks and recreational facilities for workers to relax and rejuvenate?',
        '**Transport**:  - Is safe and reliable transportation to and from the workplace provided?',
        '**Education for Workers Ch ildren**:  - Are educational scholarships or programs available for the children of laborers?',
        '**Skill Development**:  - Is there access to continuous education and skill development programs to enhance workers’ career prospects?',
        '**Personal Development**:  - Are personal development workshops (financial literacy, digital skills) organized for workers?',
        '**Non-Monetary Benefits**:  - Do you offer non-monetary benefits like paid parental leave, sick leave, and holiday pay?',
        '**Healthcare Access**:  - Are workers and their families provided with comprehensive health insurance and free medical check-ups?',
        '**Mental Health Support**:  - Do you offer mental health support, including counseling services and mental wellness programs?',
        '**Housing Support**:  - Are there initiatives for affordable, safe, and comfortable housing for workers and their families?',
        '**Community Building**:  - Do you organize community-building activities to strengthen camaraderie among workers?',
        '**Legal Assistance**: - Is free legal assistance available for workers to help them with any personal or professional legal issues?',
        '**Recognition Programs**:  - Are there programs to recognize and reward outstanding performance and long-term commitment?',
        '**Cultural and Recreational Activities**:  - Do you organize cultural events, sports activities, and excursions for the enjoyment of workers?',
        '**Worker Representation**:  - Do you ensure that workers have a voice through elected representatives or worker committees?',
        '**Feedback Mechanisms**:  - Is there a safe and anonymous way for workers to provide feedback and report grievances?',
        '**Career Progression**:  - Are clear and fair pathways to promotion and career advancement established for all workers?',
        '**Cooling Measures**:  - Are there adequate measures in place to keep workers cool, such as shaded rest areas or portable cooling devices?',
        '**Hydration**:  - Is there constant access to clean, cold drinking water in the fields?',
        '**Protective Clothing**:  - Are workers provided with breathable, protective clothing to shield them from the sun and harmful pesticides?',
        '**Rest Breaks**:  - Are frequent and regular rest breaks mandated to prevent exhaustion and heat-related illnesses?',
        '**Mechanization**:  - Are there plans or efforts to introduce mechanized picking tools to reduce the physical strain on workers?',
        '**Shade Structures**:  - Are temporary shade structures set up in the fields where workers can take breaks?',
        '**Sanitation Facilities**:  - Are clean, convenient sanitation facilities available close to the fields?',
        '**First Aid**:   - Is there always a first aid kit and trained personnel available for immediate response to injuries or health issues?',
        '**Working Hours**:  - Are working hours scheduled to avoid the hottest parts of the day, starting earlier or ending later?',
        '**Training**:  - Do workers undergo training on proper picking techniques to minimize physical strain and injury?',
        '**Mental Health Breaks**:  - Are provisions made for mental health days to cope with the taxing nature of the job?',
        '**Insect Repellent**:  - Is insect repellent provided to workers to prevent bites and stings?',
        '**Ergonomic Tools**:  - Are ergonomic tools and equipment available to reduce physical strain and enhance efficiency?',
        '**Pesticide Exposure**:  - Are there strict protocols to minimize direct exposure to pesticides and other harmful chemicals?',
        '**Transportation**:  - Is safe and comfortable transportation available to and from the fields?',
        '**Team Support**:  - Are team leaders or supervisors trained to offer support and assistance to improve working conditions?',
        '**Weather Monitoring**:  - Is there a system in place to monitor and respond to weather conditions to ensure safety during extreme heat?',
        '**Post-Work Recovery**:  - Are post-work recovery facilities (like cooling rooms, massage services) available to help workers recuperate?',
        '**Job Rotation**:  - Is job rotation practiced to vary tasks and prevent repetitive strain and exhaustion?',
        '**Employee Feedback**:  - Is there a regular feedback mechanism allowing workers to share concerns and suggest improvements about their work environment?',
        '**Health Screenings**:  - Are regular health screenings provided to check for any work-related health issues?',
        '**Mental Health Support**:  - Are mental health counseling services available to assist workers with stress and anxiety?',
        '**Nutrition**:  - Are nutritious meals and snacks provided to keep energy levels up during long working hours?',
        '**Health Insurance**:  - Do workers have access to health insurance coverage to address any medical needs arising from their work?',
        '**Workplace Safety Training**:  - Are workers regularly trained on workplace safety protocols to prevent accidents?',
        '**Pest Control**:  - Are effective pest control measures in place to reduce the risk of bites and other hazards in the fields?',
        '**Work-Life Balance**:  - Are there policies in place to ensure a good work-life balance for the workers?',
        '**Community Facilities**:  - Are community facilities (like childcare and education centers) available for the families of workers?',
        '**Workers Rights Education**:  - Are workers informed about their rights and the steps they can take if they face any work-related issues?',
        '**Grievance Mechanism**:  - Is there a transparent and effective grievance mechanism for workers to report and resolve any concerns?',
        '**Overtime Compensation**:  - Are workers properly compensated for overtime, and are there limits to prevent excessive working hours?',
        '**Living Conditions**:  - Are decent living conditions provided, including clean housing and basic amenities, for those who live on-site?',
        '**Communication**:  - Are there open lines of communication between workers and management for ongoing dialogue and feedback?',
        '**Technology Use**:  - How can technology be leveraged to make the picking process easier and more efficient?',
        '**Cultural Sensitivity**:  - Are cultural sensitivities respected in the workplace, ensuring a respectful and inclusive environment?',
        '**Disaster Preparedness**:  - Is there a clear plan in place for emergencies like extreme weather, ensuring the safety of workers?',
        '**Financial Literacy**:  - Are financial literacy programs offered to help workers manage their earnings effectively?',
        '**Incentive Programs**:  - Are there incentive programs in place to reward exceptional performance and productivity?',
        '**Community Engagement**:  - Are initiatives in place to engage with and support the local community where workers live and work?',
        '**Continued Education**:  - Are opportunities provided for continued education and skill development to ensure long-term career growth?',

        'Freedom of association and collective bargaining',

        'Do you and your employees ensure that all workers are free to join a workers’ organization of their own choosing?',
        'Are workers within your organization allowed to participate in group negotiations regarding their working conditions?',
        'Do you and your employees permit trade unions that do not have a base in the organization to meet with workers and share information without interference?',
        'Do you and your employees ensure there is no discrimination against workers and their representatives for organizing, joining (or not joining) a workers’ organization, or for participating in the legal activities of the workers’ organization?',
        'If there is no recognized and active union in your area, or if unions are forbidden by law or government-managed, do you encourage workers to democratically elect a workers’ organization?',
        'Do you and your employees provide training to workers to improve their awareness about their rights and duties during paid working hours?',
        'Do you and your employees gradually increase salaries above the regional average and the official minimum wage?',
        'Do you and your employees set maternity leave, social security provisions, and non-mandatory benefits according to the most favorable conditions for the worker, whether its national laws or agreements with workers organizations?',
        'If equivalent benefits like pension schemes or social security cannot be provided to certain workers (e.g., migrant or temporary/seasonal), does your organization offer an alternative and equivalent benefit through other means?',

      ],
    },
  ];

  void _onReject() {
    widget.onAccept();
    Navigator.pop(context);
  }

  void _onAccept() {
    if (_currentPage < sections.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    } else {
      widget.onAccept();
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms and Conditions'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [ Color(0xFF6EDB7B), // Green// Light green
              Color(0xFFCBFF6B),],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: PageView.builder(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _currentPage = index;
              if (index == sections.length - 1) {
                //Timer(Duration(seconds: 5), _onAccept);
              }
            });
          },
          itemCount: sections.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    sections[index]['heading'],
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView(
                      children: List<Widget>.from(
                        sections[index]['text'].map(
                              (text) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              text,
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (_currentPage < sections.length - 1)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: _onReject,
                          child: const Text('Reject'),
                        ),
                        ElevatedButton(
                          onPressed: _onAccept,
                          child: const Text('Accept'),
                        ),
                      ],
                    ),
                  if (_currentPage == sections.length - 1)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: _onAccept,
                          child: const Text('Proceed'),
                        ),
                      ],
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

}

