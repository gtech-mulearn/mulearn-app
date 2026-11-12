import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mulearn_app/core/theme/mu_radius.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';
import 'package:mulearn_app/core/widgets/mu_buttons.dart';
import 'package:mulearn_app/core/widgets/searchable_select_field.dart';
import 'package:mulearn_app/features/auth/domain/entities/company_details.dart';
import 'package:mulearn_app/features/auth/presentation/providers/register_providers.dart';
import 'package:mulearn_app/features/auth/presentation/providers/register_submit_controller.dart';

const _kCompanySizeOptions = [
  SelectOption(id: '1-10', label: '1–10 employees'),
  SelectOption(id: '11-50', label: '11–50 employees'),
  SelectOption(id: '51-200', label: '51–200 employees'),
  SelectOption(id: '201-500', label: '201–500 employees'),
  SelectOption(id: '501-1000', label: '501–1,000 employees'),
  SelectOption(id: '1000+', label: '1,000+ employees'),
];

const _kCompanySteps = ['Basic Info', 'Contact', 'Location', 'Legal Info'];

/// Company role details — a 4-step sub-wizard (Basic Info / Contact /
/// Location / Legal Info), matching the reference's `companyDetailsSchema`
/// and step layout exactly. `poc_name`/`poc_email` come from step 1 of the
/// outer flow (basic info), not collected here.
///
/// All steps' fields stay mounted (`Visibility(maintainState: true)`) under
/// one [Form] so the final submit validates everything entered so far, not
/// just the currently-visible step — matching the reference's
/// react-hook-form behavior of tracking all registered fields regardless of
/// conditional rendering.
class CompanyDetailsForm extends ConsumerStatefulWidget {
  const CompanyDetailsForm({required this.onSubmitted, super.key});

  final VoidCallback onSubmitted;

  @override
  ConsumerState<CompanyDetailsForm> createState() => _CompanyDetailsFormState();
}

class _CompanyDetailsFormState extends ConsumerState<CompanyDetailsForm> {
  final _formKey = GlobalKey<FormState>();
  int _step = 1;

  final _companyNameController = TextEditingController();
  final _logoController = TextEditingController();
  final _companyDescriptionController = TextEditingController();
  final _shortPitchController = TextEditingController();
  final _industrySectorController = TextEditingController();
  String? _companySize;

  final _emailController = TextEditingController();
  final _websiteLinkController = TextEditingController();
  final _linkedinUrlController = TextEditingController();

  final _locationController = TextEditingController();
  String? _countryId;
  String? _stateId;
  String? _districtId;

  final _legalNameController = TextEditingController();
  final _registrationNumberController = TextEditingController();
  final _taxIdController = TextEditingController();
  final _foundedYearController = TextEditingController();
  final _remotePolicyController = TextEditingController();
  final _cultureTextController = TextEditingController();

  @override
  void dispose() {
    _companyNameController.dispose();
    _logoController.dispose();
    _companyDescriptionController.dispose();
    _shortPitchController.dispose();
    _industrySectorController.dispose();
    _emailController.dispose();
    _websiteLinkController.dispose();
    _linkedinUrlController.dispose();
    _locationController.dispose();
    _legalNameController.dispose();
    _registrationNumberController.dispose();
    _taxIdController.dispose();
    _foundedYearController.dispose();
    _remotePolicyController.dispose();
    _cultureTextController.dispose();
    super.dispose();
  }

  void _next() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    FocusScope.of(context).unfocus();
    setState(() => _step += 1);
  }

  void _back() {
    FocusScope.of(context).unfocus();
    setState(() => _step -= 1);
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    FocusScope.of(context).unfocus();

    final details = CompanyDetails(
      companyName: _companyNameController.text.trim(),
      companyDescription: _companyDescriptionController.text.trim(),
      logo: _logoController.text.trim(),
      shortPitch: _shortPitchController.text.trim(),
      industrySector: _industrySectorController.text.trim(),
      companySize: _companySize,
      websiteLink: _websiteLinkController.text.trim(),
      email: _emailController.text.trim(),
      linkedinUrl: _linkedinUrlController.text.trim(),
      location: _locationController.text.trim(),
      countryId: _countryId,
      stateId: _stateId,
      districtId: _districtId,
      legalName: _legalNameController.text.trim(),
      registrationNumber: _registrationNumberController.text.trim(),
      taxId: _taxIdController.text.trim(),
      foundedYear: int.tryParse(_foundedYearController.text.trim()),
      remotePolicy: _remotePolicyController.text.trim(),
      cultureText: _cultureTextController.text.trim(),
    );

    try {
      await ref
          .read(registerSubmitControllerProvider.notifier)
          .submitCompany(details);
      widget.onSubmitted();
    } on Object catch (_) {
      // Surfaced via the ref.listen snackbar in the parent screen.
    }
  }

  String? _optionalUrl(String? value) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return null;
    return Uri.tryParse(v)?.hasScheme ?? false ? null : 'Enter a valid URL.';
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(registerSubmitControllerProvider).isLoading;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _StepHeader(step: _step),
          const SizedBox(height: MuSpace.xl),
          _visibleStep(1, _basicInfoStep(isLoading)),
          _visibleStep(2, _contactStep(isLoading)),
          _visibleStep(3, _locationStep(isLoading)),
          _visibleStep(4, _legalInfoStep(isLoading)),
          const SizedBox(height: MuSpace.xl),
          Row(
            children: [
              if (_step > 1)
                Expanded(
                  child: MuGhostButton(label: 'Back', onPressed: isLoading ? null : _back),
                ),
              if (_step > 1) const SizedBox(width: MuSpace.s),
              Expanded(
                child: MuPrimaryButton(
                  label: isLoading
                      ? 'Submitting…'
                      : (_step < 4 ? 'Next' : 'Complete Registration'),
                  onPressed: isLoading ? null : (_step < 4 ? _next : _submit),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _visibleStep(int step, Widget child) => Visibility(
        visible: _step == step,
        maintainState: true,
        maintainAnimation: true,
        child: child,
      );

  Widget _basicInfoStep(bool isLoading) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          controller: _companyNameController,
          enabled: !isLoading,
          decoration: const InputDecoration(labelText: 'Company Name'),
          validator: (value) {
            final v = value?.trim() ?? '';
            if (v.isEmpty) return 'Company name is required.';
            if (v.length > 75) return 'Max 75 characters.';
            return null;
          },
        ),
        const SizedBox(height: MuSpace.l),
        TextFormField(
          controller: _logoController,
          enabled: !isLoading,
          decoration: const InputDecoration(
            labelText: 'Logo URL',
            hintText: 'https://example.com/logo.png',
          ),
          validator: _optionalUrl,
        ),
        const SizedBox(height: MuSpace.l),
        TextFormField(
          controller: _companyDescriptionController,
          enabled: !isLoading,
          decoration: const InputDecoration(labelText: 'Description'),
          validator: (value) =>
              (value?.trim().isEmpty ?? true) ? 'Description is required.' : null,
        ),
        const SizedBox(height: MuSpace.l),
        TextFormField(
          controller: _shortPitchController,
          enabled: !isLoading,
          decoration: const InputDecoration(labelText: 'Short Pitch'),
        ),
        const SizedBox(height: MuSpace.l),
        TextFormField(
          controller: _industrySectorController,
          enabled: !isLoading,
          decoration: const InputDecoration(labelText: 'Industry Sector'),
        ),
        const SizedBox(height: MuSpace.l),
        SearchableSelectField(
          label: 'Company Size',
          options: _kCompanySizeOptions,
          enabled: !isLoading,
          initialValue: _companySize,
          onSelected: (value) => setState(() => _companySize = value),
        ),
      ],
    );
  }

  Widget _contactStep(bool isLoading) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          controller: _emailController,
          enabled: !isLoading,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(labelText: 'Email'),
          validator: (value) {
            final v = value?.trim() ?? '';
            if (v.isEmpty) return null;
            return v.contains('@') ? null : 'Invalid email address.';
          },
        ),
        const SizedBox(height: MuSpace.l),
        TextFormField(
          controller: _websiteLinkController,
          enabled: !isLoading,
          decoration: const InputDecoration(labelText: 'Website'),
          validator: _optionalUrl,
        ),
        const SizedBox(height: MuSpace.l),
        TextFormField(
          controller: _linkedinUrlController,
          enabled: !isLoading,
          decoration: const InputDecoration(labelText: 'LinkedIn URL'),
          validator: _optionalUrl,
        ),
      ],
    );
  }

  Widget _locationStep(bool isLoading) {
    final countries = ref.watch(registerCountriesProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          controller: _locationController,
          enabled: !isLoading,
          decoration: const InputDecoration(
            labelText: 'Location',
            hintText: 'Kochi, Kerala',
          ),
        ),
        const SizedBox(height: MuSpace.l),
        countries.when(
          data: (options) => SearchableSelectField(
            label: 'Country',
            options: options.map((o) => SelectOption(id: o.id, label: o.name)).toList(),
            enabled: !isLoading,
            initialValue: _countryId,
            onSelected: (value) => setState(() {
              _countryId = value;
              _stateId = null;
              _districtId = null;
            }),
          ),
          loading: () => const SearchableSelectField(
            label: 'Country',
            options: [],
            isLoading: true,
            onSelected: _noop,
          ),
          error: (_, _) => const SearchableSelectField(
            label: 'Country',
            options: [],
            hintText: 'Failed to load — pull to retry',
            onSelected: _noop,
          ),
        ),
        const SizedBox(height: MuSpace.l),
        if (_countryId == null)
          const SearchableSelectField(
            label: 'State',
            options: [],
            enabled: false,
            hintText: 'Select a country first',
            onSelected: _noop,
          )
        else
          _StatePicker(
            countryId: _countryId!,
            selectedId: _stateId,
            enabled: !isLoading,
            onSelected: (value) => setState(() {
              _stateId = value;
              _districtId = null;
            }),
          ),
        const SizedBox(height: MuSpace.l),
        if (_stateId == null)
          const SearchableSelectField(
            label: 'District',
            options: [],
            enabled: false,
            hintText: 'Select a state first',
            onSelected: _noop,
          )
        else
          _DistrictPicker(
            stateId: _stateId!,
            selectedId: _districtId,
            enabled: !isLoading,
            onSelected: (value) => setState(() => _districtId = value),
          ),
      ],
    );
  }

  Widget _legalInfoStep(bool isLoading) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          controller: _legalNameController,
          enabled: !isLoading,
          decoration: const InputDecoration(labelText: 'Legal Name'),
        ),
        const SizedBox(height: MuSpace.l),
        TextFormField(
          controller: _registrationNumberController,
          enabled: !isLoading,
          decoration: const InputDecoration(labelText: 'Registration Number'),
        ),
        const SizedBox(height: MuSpace.l),
        TextFormField(
          controller: _taxIdController,
          enabled: !isLoading,
          decoration: const InputDecoration(labelText: 'Tax ID / GSTIN'),
        ),
        const SizedBox(height: MuSpace.l),
        TextFormField(
          controller: _foundedYearController,
          enabled: !isLoading,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: 'Founded Year'),
        ),
        const SizedBox(height: MuSpace.l),
        TextFormField(
          controller: _remotePolicyController,
          enabled: !isLoading,
          decoration: const InputDecoration(
            labelText: 'Remote Policy',
            hintText: 'Hybrid, Fully Remote',
          ),
        ),
        const SizedBox(height: MuSpace.l),
        TextFormField(
          controller: _cultureTextController,
          enabled: !isLoading,
          decoration: const InputDecoration(labelText: 'Culture'),
        ),
      ],
    );
  }
}

void _noop(String? _) {}

class _StepHeader extends StatelessWidget {
  const _StepHeader({required this.step});

  final int step;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Step $step of ${_kCompanySteps.length}: ${_kCompanySteps[step - 1]}',
          style: MuType.bodyMed,
        ),
        const SizedBox(height: MuSpace.s),
        Row(
          children: [
            for (var i = 1; i <= _kCompanySteps.length; i++) ...[
              Expanded(
                child: Container(
                  height: 4,
                  decoration: BoxDecoration(
                    color: i <= step
                        ? MuColors.primary
                        : MuColors.divider,
                    borderRadius: BorderRadius.circular(MuRadius.chip),
                  ),
                ),
              ),
              if (i != _kCompanySteps.length) const SizedBox(width: MuSpace.xs),
            ],
          ],
        ),
      ],
    );
  }
}

class _StatePicker extends ConsumerWidget {
  const _StatePicker({
    required this.countryId,
    required this.selectedId,
    required this.enabled,
    required this.onSelected,
  });

  final String countryId;
  final String? selectedId;
  final bool enabled;
  final ValueChanged<String?> onSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final states = ref.watch(registerStatesProvider(countryId));
    return states.when(
      data: (options) => SearchableSelectField(
        label: 'State',
        options: options.map((o) => SelectOption(id: o.id, label: o.name)).toList(),
        enabled: enabled,
        initialValue: selectedId,
        onSelected: onSelected,
      ),
      loading: () => SearchableSelectField(
        label: 'State',
        options: const [],
        isLoading: true,
        onSelected: onSelected,
      ),
      error: (_, _) => SearchableSelectField(
        label: 'State',
        options: const [],
        hintText: 'Failed to load — pull to retry',
        onSelected: onSelected,
      ),
    );
  }
}

class _DistrictPicker extends ConsumerWidget {
  const _DistrictPicker({
    required this.stateId,
    required this.selectedId,
    required this.enabled,
    required this.onSelected,
  });

  final String stateId;
  final String? selectedId;
  final bool enabled;
  final ValueChanged<String?> onSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final districts = ref.watch(registerDistrictsProvider(stateId));
    return districts.when(
      data: (options) => SearchableSelectField(
        label: 'District',
        options: options.map((o) => SelectOption(id: o.id, label: o.name)).toList(),
        enabled: enabled,
        initialValue: selectedId,
        onSelected: onSelected,
      ),
      loading: () => SearchableSelectField(
        label: 'District',
        options: const [],
        isLoading: true,
        onSelected: onSelected,
      ),
      error: (_, _) => SearchableSelectField(
        label: 'District',
        options: const [],
        hintText: 'Failed to load — pull to retry',
        onSelected: onSelected,
      ),
    );
  }
}
