// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import { Turbo } from "@hotwired/turbo-rails";
import "./controllers";
import "./direct_uploads";
import * as bootstrap from "bootstrap";
import * as ActiveStorage from "@rails/activestorage";
import "trix";

// always show progress bar
Turbo.setProgressBarDelay(0);

ActiveStorage.start();

// Set auto color mode
// https://getbootstrap.com/docs/5.3/customize/color-modes/#javascript

const inverted = {
  dark: 'light',
  light: 'dark'
};

const getPreferredTheme = () => {
  return window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light'
};

const setTheme = function (theme) {
  if (theme === 'auto' && window.matchMedia('(prefers-color-scheme: dark)').matches) {
    document.documentElement.setAttribute('data-bs-theme', 'dark');
  } else {
    document.documentElement.setAttribute('data-bs-theme', theme);
    document.getElementById('logo').setAttribute('src', `/logo-${inverted[theme]}.png`);
  }
};

setTheme(getPreferredTheme());
