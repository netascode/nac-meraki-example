
*** Settings ***
Library    String
Library    ../myutils.py

*** Test Cases ***
{% for domain in meraki.domains | default([], true) %}
{% for organization in domain.organizations | default([], true) %}

{% set admins = organization.admins | default([], true) %}
Verify Array {{ organization.name }}/admins admins{% if admins | length > 0 %}
    [Setup]   Get Meraki Data   /organizations/{organizationId}/admins   ['{{ organization.name }}']   admins
    ${evaluated}=    Evaluate    {{ admins }}
    ${validated}=    Validate Subset     ${admins}    ${evaluated}
    Should Be True   ${validated}
{% else %}
    Skip   admins is not defined
{% endif %}


{% endfor %}
{% endfor %}
