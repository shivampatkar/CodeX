<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Settings</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Source+Code+Pro:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
    <link rel="stylesheet" href="static/css/home.css">
    <link rel="stylesheet" href="static/css/header.css">
    <style>
        body{
            font-family: 'Poppins', sans-serif;
        }
       
        
    </style>
</head>
<body>

    <c:import url="header.jsp" />

    <div class="container-fluid">
        <div class="row">
            <div class="col-auto bg-light" style="width: 240px;">
                <c:import url="navbar.jsp" />
            </div>
            <div class="col-md-10 ms-sm-auto px-4 py-3 bg-light">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                  <h1 class="h2">Settings</h1>
                  <div class="btn-toolbar mb-2 mb-md-0">
                    <button type="button" class="btn btn-sm btn-primary me-2" id="saveSettings">
                      <i class="bi bi-save"></i> Save
                    </button>
                    <button type="button" class="btn btn-sm btn-outline-secondary" id="resetSettings">
                      <i class="bi bi-arrow-counterclockwise"></i> Reset
                    </button>
                  </div>
                </div>
                
                <!-- Settings Content -->
                <div class="row g-3">
                  <!-- Notification Settings -->
                  <div class="col-md-6 mb-4">
                    <div class="card border-0 shadow-sm h-100">
                      <div class="card-header bg-light">
                        <h5 class="mb-0"><i class="bi bi-bell me-2"></i>Notification Settings</h5>
                      </div>
                      <div class="card-body">
                        <form>
                          <div class="mb-4">
                            <div class="form-check form-switch mb-3">
                              <input class="form-check-input" type="checkbox" id="enableNotifications" checked>
                              <label class="form-check-label fw-medium" for="enableNotifications">Enable Notifications</label>
                            </div>
                          </div>
                          <div class="mb-3">
                            <label class="d-block mb-3 fw-medium">Notification Types</label>
                            <div class="form-check mb-3">
                              <input class="form-check-input" type="checkbox" id="notifyReplies" checked>
                              <label class="form-check-label" for="notifyReplies">Replies to my posts</label>
                            </div>
                            <div class="form-check mb-3">
                              <input class="form-check-input" type="checkbox" id="notifyMentions" checked>
                              <label class="form-check-label" for="notifyMentions">Mentions (@username)</label>
                            </div>
                            <div class="form-check">
                              <input class="form-check-input" type="checkbox" id="notifyTopics" checked>
                              <label class="form-check-label" for="notifyTopics">New topics in followed categories</label>
                            </div>
                          </div>
                        </form>
                      </div>
                    </div>
                  </div>
                  
                  <!-- Privacy Settings -->
                  <div class="col-md-6 mb-4">
                    <div class="card border-0 shadow-sm h-100">
                      <div class="card-header bg-light">
                        <h5 class="mb-0"><i class="bi bi-shield-lock me-2"></i>Privacy Settings</h5>
                      </div>
                      <div class="card-body">
                        <form>
                          <div class="mb-4">
                            <label class="d-block mb-3 fw-medium">Profile Visibility</label>
                            <div class="form-check mb-3">
                              <input class="form-check-input" type="radio" name="profileVisibility" id="visibilityPublic" checked>
                              <label class="form-check-label" for="visibilityPublic">Public (Anyone can view)</label>
                            </div>
                            <div class="form-check">
                              <input class="form-check-input" type="radio" name="profileVisibility" id="visibilityMembers">
                              <label class="form-check-label" for="visibilityMembers">Members Only</label>
                            </div>
                          </div>
                          <div class="mb-3">
                            <div class="form-check form-switch mb-3">
                              <input class="form-check-input" type="checkbox" id="showOnlineStatus" checked>
                              <label class="form-check-label" for="showOnlineStatus">Show my online status</label>
                            </div>
                            <div class="form-check form-switch">
                              <input class="form-check-input" type="checkbox" id="showActivity" checked>
                              <label class="form-check-label" for="showActivity">Show my activity in forum</label>
                            </div>
                          </div>
                        </form>
                      </div>
                    </div>
                  </div>
                  
                  <!-- Security Settings -->
                  <div class="col-md-6 mb-4">
                    <div class="card border-0 shadow-sm h-100">
                      <div class="card-header bg-light">
                        <h5 class="mb-0"><i class="bi bi-fingerprint me-2"></i>Security Settings</h5>
                      </div>
                      <div class="card-body">
                        <form>
                          <div class="mb-4">
                            <label class="fw-medium mb-3">Account Security</label>
                            <div class="d-grid mb-3">
                              <button type="button" class="btn btn-outline-primary">
                                <i class="bi bi-key me-2"></i>Change Password
                              </button>
                            </div>
                          </div>
                          <div class="mb-3">
                            <div class="form-check form-switch">
                              <input class="form-check-input" type="checkbox" id="twoFactorAuth">
                              <label class="form-check-label fw-medium" for="twoFactorAuth">Enable Two-Factor Authentication</label>
                            </div>
                            <small class="text-muted d-block mt-2">Adds an extra layer of security to your account by requiring a code from your phone in addition to your password</small>
                          </div>
                        </form>
                      </div>
                    </div>
                  </div>
                  
                  <!-- Communication Settings -->
                  <div class="col-md-6 mb-4">
                    <div class="card border-0 shadow-sm h-100">
                      <div class="card-header bg-light">
                        <h5 class="mb-0"><i class="bi bi-envelope me-2"></i>Communication Preferences</h5>
                      </div>
                      <div class="card-body">
                        <form>
                          <div class="mb-4">
                            <label class="d-block mb-3 fw-medium">Email Frequency</label>
                            <div class="form-check mb-3">
                              <input class="form-check-input" type="radio" name="emailFrequency" id="emailImmediate" checked>
                              <label class="form-check-label" for="emailImmediate">Send immediately</label>
                            </div>
                            <div class="form-check mb-3">
                              <input class="form-check-input" type="radio" name="emailFrequency" id="emailDaily">
                              <label class="form-check-label" for="emailDaily">Daily digest</label>
                            </div>
                            <div class="form-check">
                              <input class="form-check-input" type="radio" name="emailFrequency" id="emailNone">
                              <label class="form-check-label" for="emailNone">No emails</label>
                            </div>
                          </div>
                          <div class="mb-3">
                            <label class="d-block mb-3 fw-medium">Communication Options</label>
                            <div class="form-check mb-3">
                              <input class="form-check-input" type="checkbox" id="receiveAnnouncements" checked>
                              <label class="form-check-label" for="receiveAnnouncements">Receive forum announcements</label>
                            </div>
                            <div class="form-check mb-3">
                              <input class="form-check-input" type="checkbox" id="receiveUpdates" checked>
                              <label class="form-check-label" for="receiveUpdates">Receive feature updates</label>
                            </div>
                            <div class="form-check">
                              <input class="form-check-input" type="checkbox" id="receiveDMs" checked>
                              <label class="form-check-label" for="receiveDMs">Allow direct messages from members</label>
                            </div>
                          </div>
                        </form>
                      </div>
                    </div>
                  </div>
                </div>
                
                <!-- Save Settings Footer -->
                <div class="row mt-3">
                  <div class="col-12">
                    <div class="card border-0 bg-light shadow-sm">
                      <div class="card-body py-3">
                        <div class="d-flex justify-content-between align-items-center">
                          <span class="text-muted">Last updated: March 9, 2025</span>
                          <button type="button" class="btn btn-primary" id="saveSettingsBottom">
                            <i class="bi bi-save me-2"></i>Save All Settings
                          </button>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
        </div>
    </div>

    

    <script src="static/js/header.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Simple validation for demonstration
        document.getElementById('saveSettings').addEventListener('click', function() {
          alert('Settings saved successfully!');
        });
        
        document.getElementById('saveSettingsBottom').addEventListener('click', function() {
          alert('Settings saved successfully!');
        });
        
        document.getElementById('resetSettings').addEventListener('click', function() {
          if(confirm('Are you sure you want to reset all settings to default?')) {
            // Reset logic would go here
            alert('Settings have been reset to default values');
          }
        });
      </script>
</body>
</html>