/// Curated catalogs for first-run setup. Values are ISO / IANA identifiers.
class CountryOption {
  const CountryOption({
    required this.code,
    required this.name,
    required this.currency,
    required this.timezone,
  });

  final String code;
  final String name;
  final String currency;
  final String timezone;
}

class TimeZoneOption {
  const TimeZoneOption({required this.id, required this.label});

  final String id;
  final String label;
}

class CurrencyOption {
  const CurrencyOption({required this.code, required this.label});

  final String code;
  final String label;
}

abstract final class LocaleCatalogs {
  static const countries = <CountryOption>[
    CountryOption(
      code: 'AE',
      name: 'United Arab Emirates',
      currency: 'AED',
      timezone: 'Asia/Dubai',
    ),
    CountryOption(
      code: 'AU',
      name: 'Australia',
      currency: 'AUD',
      timezone: 'Australia/Sydney',
    ),
    CountryOption(
      code: 'BR',
      name: 'Brazil',
      currency: 'BRL',
      timezone: 'America/Sao_Paulo',
    ),
    CountryOption(
      code: 'CA',
      name: 'Canada',
      currency: 'CAD',
      timezone: 'America/Toronto',
    ),
    CountryOption(
      code: 'DE',
      name: 'Germany',
      currency: 'EUR',
      timezone: 'Europe/Berlin',
    ),
    CountryOption(
      code: 'GB',
      name: 'United Kingdom',
      currency: 'GBP',
      timezone: 'Europe/London',
    ),
    CountryOption(
      code: 'IN',
      name: 'India',
      currency: 'INR',
      timezone: 'Asia/Kolkata',
    ),
    CountryOption(
      code: 'PK',
      name: 'Pakistan',
      currency: 'PKR',
      timezone: 'Asia/Karachi',
    ),
    CountryOption(
      code: 'SA',
      name: 'Saudi Arabia',
      currency: 'SAR',
      timezone: 'Asia/Riyadh',
    ),
    CountryOption(
      code: 'US',
      name: 'United States',
      currency: 'USD',
      timezone: 'America/New_York',
    ),
    CountryOption(
      code: 'ZA',
      name: 'South Africa',
      currency: 'ZAR',
      timezone: 'Africa/Johannesburg',
    ),
  ];

  static const timezones = <TimeZoneOption>[
    TimeZoneOption(id: 'UTC', label: 'UTC'),
    TimeZoneOption(id: 'Africa/Johannesburg', label: 'Africa/Johannesburg'),
    TimeZoneOption(id: 'America/Chicago', label: 'America/Chicago'),
    TimeZoneOption(id: 'America/Los_Angeles', label: 'America/Los_Angeles'),
    TimeZoneOption(id: 'America/New_York', label: 'America/New_York'),
    TimeZoneOption(id: 'America/Sao_Paulo', label: 'America/Sao_Paulo'),
    TimeZoneOption(id: 'America/Toronto', label: 'America/Toronto'),
    TimeZoneOption(id: 'Asia/Dubai', label: 'Asia/Dubai'),
    TimeZoneOption(id: 'Asia/Karachi', label: 'Asia/Karachi'),
    TimeZoneOption(id: 'Asia/Kolkata', label: 'Asia/Kolkata'),
    TimeZoneOption(id: 'Asia/Riyadh', label: 'Asia/Riyadh'),
    TimeZoneOption(id: 'Australia/Sydney', label: 'Australia/Sydney'),
    TimeZoneOption(id: 'Europe/Berlin', label: 'Europe/Berlin'),
    TimeZoneOption(id: 'Europe/London', label: 'Europe/London'),
  ];

  static const currencies = <CurrencyOption>[
    CurrencyOption(code: 'AED', label: 'AED'),
    CurrencyOption(code: 'AUD', label: 'AUD'),
    CurrencyOption(code: 'BRL', label: 'BRL'),
    CurrencyOption(code: 'CAD', label: 'CAD'),
    CurrencyOption(code: 'EUR', label: 'EUR'),
    CurrencyOption(code: 'GBP', label: 'GBP'),
    CurrencyOption(code: 'INR', label: 'INR'),
    CurrencyOption(code: 'PKR', label: 'PKR'),
    CurrencyOption(code: 'SAR', label: 'SAR'),
    CurrencyOption(code: 'USD', label: 'USD'),
    CurrencyOption(code: 'ZAR', label: 'ZAR'),
  ];

  static CountryOption byCode(String code) {
    return countries.firstWhere(
      (c) => c.code == code,
      orElse: () => countries.firstWhere((c) => c.code == 'US'),
    );
  }
}
