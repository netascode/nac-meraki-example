
*** Settings ***
Library    String
Library    ../myutils.py

*** Test Cases ***
{% for domain in meraki.domains | default([], true) %}
{% for organization in domain.organizations | default([], true) %}
{% for network in organization.networks | default([], true) %}

{% if (network.managed | default(true)) == false %}
{{ organization.name }}/networks/{{ network.name }} (unmanaged)
    Skip    network.managed is false
{% else %}

Verify {{ organization.name }}/networks/{{ network.name }}//name{% if network.name is defined %}
    [Setup]   Get Meraki Data   /networks/{networkId}   ['{{ organization.name }}', '{{ network.name }}']   network
    Should Be Equal As Strings   ${network}[name]   {{ network.name }}
{% else %}
    Skip    network.name is not defined
{% endif %}

Verify {{ organization.name }}/networks/{{ network.name }}//time_zone{% if network.time_zone is defined %}
    [Setup]   Get Meraki Data   /networks/{networkId}   ['{{ organization.name }}', '{{ network.name }}']   network
    Should Be Equal As Strings   ${network}[timeZone]   {{ network.time_zone }}
{% else %}
    Skip    network.time_zone is not defined
{% endif %}

{% endif %}  {# end managed check #}

{% endfor %}
{% endfor %}
{% endfor %}
