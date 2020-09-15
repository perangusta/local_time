
LocalTime.getI18nValue = (keyPath = "", { locale } = { locale: LocalTime.config.locale }) ->
  value = getValue(LocalTime.config.i18n[locale], keyPath)
  if value?
    value
  else if locale isnt LocalTime.config.defaultLocale
    LocalTime.getI18nValue(keyPath, { locale: LocalTime.config.defaultLocale })

LocalTime.translate = (keyPath, interpolations = {}, options) ->
  string = LocalTime.getI18nValue(keyPath, options)
  for key, replacement of interpolations
    string = string.replace("{#{key}}", replacement)
  string

getValue = (object, keyPath) ->
  value = object
  for key in keyPath.split(".")
    if value[key]?
      value = value[key]
    else
      return null
  value
