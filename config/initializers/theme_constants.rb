# app/constants/theme_constants.rb

module ThemeConstants
    # Primary Colors
    PRIMARY_COLOR_LIGHT = '#47B5A4'         # Matches $primary-color-light in SCSS
    SECONDARY_COLOR_LIGHT = '#FF6F61'       # Matches $secondary-color-light in SCSS
    TERTIARY_COLOR_LIGHT = '#4A4A4A'        # Matches $tertiary-color-light in SCSS
    NEUTRAL_LIGHT = '#EDE8DC'               # Matches $neutral-light in SCSS
    BACKGROUND_COLOR_LIGHT = '#F7F3E9'      # Matches $background-color-light in SCSS

    PRIMARY_COLOR_DARK = '#47B5A4'          # Matches $primary-color-dark in SCSS
    SECONDARY_COLOR_DARK = '#FF6F61'        # Matches $secondary-color-dark in SCSS
    TERTIARY_COLOR_DARK = '#E0E0E0'         # Matches $tertiary-color-dark in SCSS
    NEUTRAL_DARK = '#4A4A4A'                # Matches $neutral-dark in SCSS
    BACKGROUND_COLOR_DARK = '#323232'       # Matches $background-color-dark in SCSS

    # Shared Colors for Feedback
    SUCCESS_COLOR = '#82B366'               # Matches $success-color in SCSS
    ERROR_COLOR = '#D95C5C'                 # Matches $error-color in SCSS
    WARNING_COLOR = '#FFA726'               # Matches $warning-color in SCSS

    # Additional UI Colors (Common for Both Themes)
    BUTTON_PRIMARY_BG = PRIMARY_COLOR_LIGHT # Button background color
    BUTTON_PRIMARY_HOVER = '#3E9E8E'        # Darkened $primary-color-light by ~10%
    BUTTON_SECONDARY_BG = SECONDARY_COLOR_LIGHT # Secondary button background
    BUTTON_SECONDARY_HOVER = '#E65A55'      # Darkened $secondary-color-light by ~10%
    BUTTON_DISABLED_BG = '#E0DFDC'          # Lightened $neutral-light by ~20%
    BUTTON_TEXT_LIGHT = '#FFFFFF'           # Button text color in light theme
    BUTTON_TEXT_DARK = '#F0F0F0'            # Button text color in dark theme

    # Link Colors
    LINK_COLOR = PRIMARY_COLOR_LIGHT        # Link color
    LINK_HOVER_COLOR = '#368C85'            # Darkened primary color by ~15%

    # Border and Divider Colors
    BORDER_COLOR_LIGHT = '#E2DED4'          # Light theme border, lightened neutral-light by ~10%
    BORDER_COLOR_DARK = '#616161'           # Dark theme border, lightened neutral-dark by ~15%

    # Background Accent Colors
    CARD_BACKGROUND_LIGHT = '#F1EEE2'       # Lightened neutral-light by ~5% for light theme
    CARD_BACKGROUND_DARK = '#292929'        # Darkened neutral-dark by ~5% for dark theme
end
