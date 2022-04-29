system("echo 'RENV_PATHS_LIBRARY_ROOT = ~/.renv/library' >> .Renviron")
rstudioapi::restartSession()
renv::init()
devtools::install_github("Novartis/shinyValidator")

usethis::use_git()
usethis::git_vaccinate()
usethis::use_git_protocol("ssh")
usethis::use_mit_license()
usethis::use_testthat()
usethis::use_test("dummy")

usethis::use_github()

shinyValidator::use_validator("github")
devtools::document()

renv::snapshot()
# Replace for binaries
# https://packagemanager.rstudio.com/all/__linux__/focal/latest

shinyValidator::audit_app(flow = FALSE, output_validation = FALSE)

# Don't forget random seed for plots with rnorm ...

# gremlins
headless_app$run_js("
  let s = document.createElement('script');
  s.src = './gremlins/gremlins.min.js';
  document.body.appendChild(s);
")
headless_app$get_html("script", outer_html = TRUE)
headless_app$get_js("typeof window.gremlins")

headless_app$run_js("
  const customToucher = gremlins.species.toucher({
    // which touch event types will be triggered
    touchTypes: ['gesture'],
    // Touch only if element has class irs-handle single
    canTouch: (element) => element.className === 'irs-handle single',
    log: true,
    maxTouches: 200
  });

  gremlins.createHorde({
    //randomizer: new gremlins.Chance(1234), // repeatable
    species: [customToucher],
    mogwais: [gremlins.mogwais.gizmo()]
  }).unleash().then(() => {
    console.log('Gremlins test success')
  });
")