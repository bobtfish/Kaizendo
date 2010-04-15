package ReqMgmt::Storage::API;
use Moose::Role;
use namespace::autoclean;

with 'KiokuDB::Role::API';

requires qw/
    get_user_by_uid
    new_user
    get_organisation_by_name
    new_organisation
    get_project_by_name
    get_all_organisations
    get_all_projects
/;

1;

