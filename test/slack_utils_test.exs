defmodule HansAndFranz.SlackUtilsTest do
  use ExUnit.Case, async: true

  setup do
    id = "RD2GU6S20"
    slack = %Slack.State{
      me: slack_me(id),
      channels: slack_channels(id),
      users: slack_users
    }
    {:ok, slack: slack}
  end

  test "channels_im_in", %{slack: slack} do
    channels = HansAndFranz.SlackUtils.channels_im_in(slack)
    assert Enum.map(channels, fn {channel_id, _channel_info} -> channel_id end) == ["ABC81GDR", "ABR9P5PMH"]
  end

  test "lookup_user", %{slack: slack} do
    {user_id, _user} = HansAndFranz.SlackUtils.lookup_user("ZYXMG0BJP", slack)
    assert user_id == "ZYXMG0BJP"
  end

  test "random_user_in_channel", %{slack: slack} do
    # [{_channel_id, channel} | _tail] = slack.channels
    {_user_id, user} = HansAndFranz.SlackUtils.random_user_in_channel("ABC81GDR", slack)
    assert user.presence == "active"
  end

  def slack_users do
    [
      {
        "ZYXMG0BJP",
        %{
          color: "de5f24",
          deleted: false,
          id: "ZYXMG0BJP",
          is_admin: false,
          is_bot: false,
          is_owner: false,
          is_primary_owner: false,
          is_restricted: false,
          is_ultra_restricted: false,
          name: "user.test1",
          presence: "active",
          profile: %{
            avatar_hash: "e86c2af56a0a",
            email: "test.test1@teamsnap.com",
            fields: %{
              Xf0DJ1B8Q6: %{
                alt: "",
                value: ":nuke: :database:",
              },
            },
            first_name: "User",
            image_1024: "https://1024.png",
            image_192: "https://192.png",
            image_24: "https://24.png",
            image_32: "https://32.png",
            image_48: "https://48.png",
            image_512: "https://512.png",
            image_72: "https://72.png",
            image_original: "https://original.png",
            last_name: "Test1",
            phone: "6145194078",
            real_name: "User Test1",
            real_name_normalized: "User Test1",
            skype: "",
            title: "Data Analyst",
          },
          real_name: "User Test1",
          status: nil,
          team_id: "T024GTX6X",
          tz: "America/Indiana/Indianapolis",
          tz_label: "Eastern Daylight Time",
          tz_offset: -14400,
        }
      },
      {
        "ZYXPCFVNE",
        %{
          color: "a2a5dc",
          deleted: false,
          id: "ZYXPCFVNE",
          is_admin: false,
          is_bot: false,
          is_owner: false,
          is_primary_owner: false,
          is_restricted: false,
          is_ultra_restricted: false,
          name: "user.user2",
          presence: "active",
          profile: %{
            avatar_hash: "6140818187bf",
            email: "user.user2@teamsnap.com",
            fields: %{
              Xf0DKA92P3: %{
                alt: "",
                value: "Fountain Valley, CA",
              },
              Xf0DKADC7R: %{
                alt: "",
                value: "1990-06-16",
              },
              Xf0DKADW95: %{
                alt: "",
                value: "",
              },
            },
            first_name: "User",
            image_192: "https://avatars.slack-edge.com92.jpg",
            image_24: "https://4.jpg",
            image_32: "https://2.jpg",
            image_48: "https://8.jpg",
            image_72: "https://2.jpg",
            image_original: "https://riginal.jpg",
            last_name: "Test2",
            phone: "7146994625",
            real_name: "User Test2",
            real_name_normalized: "User Test2",
            title: "Android Developer",
          },
          real_name: "User Test2",
          status: nil,
          team_id: "T024GTX6X",
          tz: "America/Los_Angeles",
          tz_label: "Pacific Daylight Time",
          tz_offset: -25200,
        }
      },
      {
        "XY29RPU72",
        %{
          color: "ea2977",
          deleted: false,
          id: "XY29RPU72",
          is_admin: false,
          is_bot: false,
          is_owner: false,
          is_primary_owner: false,
          is_restricted: false,
          is_ultra_restricted: false,
          name: "user.test3",
          presence: "away",
          profile: %{
            avatar_hash: "g3af668c3ebf",
            email: "user.test3@teamsnap.com",
            fields: %{
              Xf0D7BRGA0: %{
                alt: "",
                value: "ryan.test3",
              },
              Xf0DKADC7R: %{
                alt: "",
                value: "",
              },
              Xf0DKADW95: %{
                alt: "",
                value: "",
              },
              Xf0DKAENF9: %{
                alt: "",
                value: "Dragon",
              },

            },
            first_name: "User",
            image_192: "fFava_0024-192.png",
            image_24: "fava_0024-24.png",
            image_32: "fava_0024-32.png",
            image_48: "fava_0024-48.png",
            image_512: "fFava_0024-512.png",
            image_72: "fava_0024-72.png",
            last_name: "Test3",
            phone: "(111) 555-5555",
            real_name: "User Test3",
            real_name_normalized: "User Test3",
            skype: "user.test3",
            title: "Engineer"
          },
          real_name: "User Test3",
          status: nil,
          team_id: "T024GTX6X",
          tz: "America/Los_Angeles",
          tz_label: "Pacific Daylight Time",
          tz_offset: -25200,
        }
      }
    ]
  end

  def slack_me(id) do
    %{
      created: 1464151802,
      id: id,
      manual_presence: "active",
      name: "hans_and_franz",
      prefs: %{
        fuller_timestamps: false,
        no_created_overlays: false,
        comma_key_prefs: false,
        spaces_new_xp_banner_dismissed: false,
        no_text_in_notifications: false,
        search_only_my_channels: false,
        emoji_autocomplete_big: false,
        sidebar_theme_custom_values: "",
        channel_sort: %{
          is_custom_sorted: false,
          priority_display: false,
          priority_type: "",
          sorts: []
        },
        display_preferred_names: true,
        k_key_omnibox: true,
        push_loud_channels_set: "",
        new_msg_snd: "knock_brush.mp3",
        full_text_extracts: false,
        confirm_clear_all_unreads: true,
        k_key_omnibox_auto_hide_count: 0,
        search_exclude_channels: "",
        email_weekly: true,
        push_dm_alert: true,
        onboarding_cancelled: false,
        seen_onboarding_invites: false,
        msg_preview_displaces: true,
        jumbomoji: true,
        mentions_exclude_at_channels: true,
        expand_non_media_attachments: true,
        dnd_start_hour: "22:00",
        no_omnibox_in_channels: false,
        seen_member_invite_reminder: false,
        search_exclude_bots: false,
        user_colors: "",
        no_winssb1_banner: false,
        f_key_search: false,
        seen_onboarding_recent_mentions: false,
        ls_disabled: false,
        seen_onboarding_private_groups: false,
        no_flex_in_history: true,
        require_at: true,
        hotness: false,
        messages_theme: "default",
        seen_welcome_2: false,
        no_macssb2_banner: false,
        whats_new_read: 1464151802,
        enter_is_special_in_tbt: false,
        confirm_sh_call_start: true,
        show_member_presence: true,
        seen_ssb_prompt: false,
        posts_formatting_guide: true,
        box_enabled: false,
        show_memory_instrument: false,
        push_mention_channels: "",
        snippet_editor_wrap_long_lines: false,
        push_mention_alert: true,
        privacy_policy_seen: true,
        frecency_jumper: "",
        preferred_skin_tone: "",
        webapp_spellcheck: true,
        winssb_run_from_tray: true,
        push_everything: false,
        separate_private_channels: false,
        seen_onboarding_start: false,
        sidebar_behavior: "",
        loud_channels_set: "",
        msg_preview_persistent: true,
        growls_enabled: true,
        confirm_user_marked_away: true,
        tz: nil,
        ssb_space_window: "",
        onboarding_slackbot_conversation_step: 0,
        last_snippet_type: "",
        show_typing: true,
        no_joined_overlays: false,
        winssb_window_flash_behavior: "idle",
        convert_emoticons: true,
        two_factor_type: nil,
        has_invited: false,
        ss_emojis: true,
        speak_growls: false,
        search_only_current_team: false,
        mentions_exclude_at_user_groups: false,
        seen_onboarding_slackbot_conversation: false,
        color_names_in_list: true,
        muted_channels: "",
        display_real_names_override: 0,
        emoji_use: "",
        two_factor_auth_enabled: false,
        all_channels_loud: false,
        dnd_enabled: false,
        load_lato_2: false,
        seen_domain_invite_reminder: false,
        search_sort: "timestamp",
        hide_user_group_info_pane: false,
        mark_msgs_read_immediately: true,
        emoji_mode: "default",
        show_all_skin_tones: false,
        seen_single_emoji_msg: false,
        pagekeys_handled: true,
        prompted_for_email_disabling: false,
        no_macssb1_banner: false,
        tab_ui_return_selects: true,
        email_alerts: "instant",
        start_scroll_at_oldest: true,
        attachments_with_borders: false,
        email_misc: true,
        flex_resize_window: false,
        expand_inline_imgs: true,
        msg_replies: %{ flexpane: false },
        seen_onboarding_search: false,
        has_created_channel: false,
        mac_ssb_bounce: "",
        email_alerts_sleep_until: 0,
        graphic_emoticons: false,
        push_loud_channels: "",
        two_factor_backup_type: nil,
        dnd_end_hour: "08:00",
        seen_onboarding_direct_messages: false,
        has_uploaded: false,
        loud_channels: "",
        never_channels: "",
        push_idle_wait: 2,
        enhanced_debugging: false,
        mac_ssb_bullet: true,
        dropbox_enabled: false,
        time24: false,
        seen_onboarding_channels: false,
        seen_onboarding_starred_items: false,
        a11y_font_size: "normal",
        msg_preview: false,
        newxp_seen_last_message: 0,
        obey_inline_img_limit: true,
        at_channel_suppressed_channels: "",
        mac_speak_voice: "com.apple.speech.synthesis.voice.Alex",
        mac_speak_speed: 250,
        highlight_words: "",
        expand_snippets: false,
        expand_internal_inline_imgs: true,
        mute_sounds: false,
        push_sound: "b2.mp3",
        push_at_channel_suppressed_channels: "",
        welcome_message_hidden: false,
        arrow_history: false,
        sidebar_theme: "default",
        last_seen_at_channel_warning: 0,
      }
    }
  end

  def slack_channels(id) do
    [
      {
        "ABC81GDR",
        %{
          created: 1464236618,
          creator: "XY4A1J5CH",
          has_pins: false,
          id: "ABC81GDR",
          is_archived: false,
          is_channel: true,
          is_general: false,
          is_member: true,
          last_read: "1464236622.000003",
          latest: %{
            text: "<@XYLAB0ECQ> Give me 16 crunches!",
            ts: "1468089385.000058",
            type: "message",
            user: "RD2GU6S20",
          },
          members: [
            "ZYXMG0BJP",
            "ZYXPCFVNE",
            "XY29RPU72",
            id
          ],
          name: "dustins-bot-test",
          purpose: %{
            creator: "",
            last_set: 0,
            value: "",
          },
          topic: %{
            creator: "",
            last_set: 0,
            value: "",
          },
          unread_count: 281,
          unread_count_display: 157,
        }
      },
      {
        "ABR9P5PMH",
        %{
          created: 1399484006,
          creator: "XY24GTX6Z",
          has_pins: false,
          id: "ABR9P5PMH",
          is_archived: false,
          is_channel: true,
          is_general: false,
          is_member: true,
          last_read: "1464152171.000057",
          latest: %{
            text: "<@ZYXJYMU7Q> Give me 13 pushups!",
            ts: "1468089385.000007",
            type: "message",
            user: "RD2GU6S20",
          },
          members: [
            "ZYXMG0BJP",
            "XY29RPU72",
            id,
          ],
          name: "test",
          purpose: %{
            creator: "XY24GTX6Z",
            last_set: 1399484006,
            value: "For testing Slack stuff and integrations without mucking up other, channels."
          },
          topic: %{
            creator: "",
            last_set: 0,
            value: "",
          },
          unread_count: 12,
          unread_count_display: 6,
        }
      },
      {
        "AAAAAAAA",
        %{
          created: 1464236618,
          creator: "XY4A1J5CH",
          has_pins: false,
          id: "ABC81GDR",
          is_archived: false,
          is_channel: true,
          is_general: false,
          is_member: false,
          last_read: "1464236622.000003",
          latest: %{
            text: "<@XYLAB0ECQ> Give me 16 crunches!",
            ts: "1468089385.000058",
            type: "message",
            user: "RD2GU6S20",
          },
          name: "test-channel",
          purpose: %{
            creator: "",
            last_set: 0,
            value: "",
          },
          topic: %{
            creator: "",
            last_set: 0,
            value: "",
          },
          unread_count: 281,
          unread_count_display: 157,
        }
      }
    ]
  end
end
