#!/bin/bash

# Test Environment Setup Script for Linux Permission Fixer
# This script creates a test environment with various permission issues
# to comprehensively test the Permission Fixer script functionality


#!/bin/bash

echo "⚠️ WARNING: This script creates insecure files and test users for demonstration purposes only."
echo "✅ Run ONLY on a disposable or test environment."


echo -e "\n\033[1;36m=== Creating Test Environment for Permission Fixer ===\033[0m"

# Create base test directory
TEST_ROOT="./permission_test_env"
mkdir -p "$TEST_ROOT"
cd "$TEST_ROOT"

echo -e "\033[1;33m➤ Creating directory structure...\033[0m"

# Create directory structure with various permissions
mkdir -p normal_dir
mkdir -p world_writable_dir
mkdir -p nested/level1/level2
mkdir -p special_cases/symlinks
mkdir -p special_cases/empty
mkdir -p by_users/user1
mkdir -p by_users/user2
mkdir -p by_users/user3

# Create test files with various permissions
echo -e "\033[1;33m➤ Creating test files with different permissions...\033[0m"

# Normal permission files
echo "This is a normal file" > normal_dir/normal_file.txt
chmod 644 normal_dir/normal_file.txt

# World-writable files (risky)
echo "This file has risky permissions" > world_writable_dir/risky_file1.txt
chmod 666 world_writable_dir/risky_file1.txt

echo "This file also has risky permissions" > world_writable_dir/risky_file2.txt
chmod 606 world_writable_dir/risky_file2.txt

# Nested world-writable files
echo "Nested risky file" > nested/level1/level2/nested_risky.txt
chmod 646 nested/level1/level2/nested_risky.txt

# Make directories world-writable
chmod 777 world_writable_dir
chmod 777 nested/level1

# Creating files of various sizes to test disk usage reporting
echo -e "\033[1;33m➤ Creating files of different sizes...\033[0m"

# Creating a 1MB file
dd if=/dev/urandom of=normal_dir/1mb_file.bin bs=1M count=1 2>/dev/null

# Creating a 5MB file
dd if=/dev/urandom of=world_writable_dir/5mb_file.bin bs=1M count=5 2>/dev/null
chmod 666 world_writable_dir/5mb_file.bin

# Creating a 10MB file
dd if=/dev/urandom of=nested/10mb_file.bin bs=1M count=10 2>/dev/null
chmod 646 nested/10mb_file.bin

# Create symlinks
echo -e "\033[1;33m➤ Creating symbolic links...\033[0m"
ln -s ../normal_dir/normal_file.txt special_cases/symlinks/link_to_normal.txt
ln -s ../world_writable_dir/risky_file1.txt special_cases/symlinks/link_to_risky.txt

# If user has sudo privileges, create files owned by different users
if command -v sudo &> /dev/null && sudo -n true 2>/dev/null; then
    echo -e "\033[1;33m➤ Creating files owned by different users (requires sudo)...\033[0m"
    
    # Check if test users exist, create them if they don't
    for test_user in test_user1 test_user2 test_user3; do
        if ! id "$test_user" &>/dev/null; then
            echo "Creating test user: $test_user"
            sudo useradd -m "$test_user"
        fi
        
        # Create files owned by these users
        echo "File owned by $test_user" | sudo tee "by_users/$test_user.txt" > /dev/null
        sudo chown "$test_user" "by_users/$test_user.txt"
        
        # Make some of these files world-writable
        if [[ "$test_user" == "test_user2" ]]; then
            sudo chmod 666 "by_users/$test_user.txt"
        fi
    done
    
    # Create some larger files owned by different users
    dd if=/dev/urandom bs=1M count=3 2>/dev/null | sudo tee "by_users/user1/3mb_file.bin" > /dev/null
    sudo chown test_user1 "by_users/user1/3mb_file.bin"
    
    dd if=/dev/urandom bs=1M count=7 2>/dev/null | sudo tee "by_users/user2/7mb_file.bin" > /dev/null
    sudo chown test_user2 "by_users/user2/7mb_file.bin"
    sudo chmod 666 "by_users/user2/7mb_file.bin"
else
    echo -e "\033[1;31m➤ Skipping multi-user tests - sudo access required\033[0m"
    # Create files with current user but still test basic functionality
    echo "User 1 file (simulation)" > "by_users/user1/user1_file.txt"
    echo "User 2 file (simulation)" > "by_users/user2/user2_file.txt"
    chmod 666 "by_users/user2/user2_file.txt"
    echo "User 3 file (simulation)" > "by_users/user3/user3_file.txt"
fi

# Create special file types
echo -e "\033[1;33m➤ Creating special files...\033[0m"

# Create an executable script
cat > normal_dir/executable.sh << 'EOF'
#!/bin/bash
echo "This is an executable file"
EOF
chmod 755 normal_dir/executable.sh

# Create a world-writable executable
cat > world_writable_dir/risky_executable.sh << 'EOF'
#!/bin/bash
echo "This is a risky executable file"
EOF
chmod 777 world_writable_dir/risky_executable.sh

# Create a file with spaces in name
echo "File with spaces" > "normal_dir/file with spaces.txt"
chmod 644 "normal_dir/file with spaces.txt"

echo "Risky file with spaces" > "world_writable_dir/risky file with spaces.txt"
chmod 666 "world_writable_dir/risky file with spaces.txt"

# Create files with special characters
echo "Special @#$% characters" > "normal_dir/special@#$%.txt"
chmod 644 "normal_dir/special@#$%.txt"

echo "Risky special @#$% characters" > "world_writable_dir/risky@#$%.txt"
chmod 666 "world_writable_dir/risky@#$%.txt"

# Summary of what we've created
echo -e "\n\033[1;32m=== Test Environment Created Successfully ===\033[0m"
echo -e "\033[1;33mTest root directory:\033[0m $TEST_ROOT"
echo -e "\033[1;33mWorld-writable files created:\033[0m $(find . -type f -perm -o=w | wc -l)"
echo -e "\033[1;33mWorld-writable directories created:\033[0m $(find . -type d -perm -o=w | wc -l)"
echo -e "\033[1;33mTotal test files:\033[0m $(find . -type f | wc -l)"

echo -e "\n\033[1;36m=== How to Test the Permission Fixer ===\033[0m"
echo -e "Run your script with the following commands to test different features:\n"
echo -e "\033[1;33m1. Basic scan (dry run):\033[0m"
echo -e "   ./permission_fixer.sh -t $TEST_ROOT\n"
echo -e "\033[1;33m2. Verbose scan:\033[0m"
echo -e "   ./permission_fixer.sh -t $TEST_ROOT -v\n"
echo -e "\033[1;33m3. Fix permissions:\033[0m"
echo -e "   ./permission_fixer.sh -t $TEST_ROOT -f\n"
echo -e "\033[1;33m4. Check disk usage by specific user (if you created test users):\033[0m"
echo -e "   ./permission_fixer.sh -t $TEST_ROOT -u test_user1\n"

echo -e "\n\033[1;35m=== Happy Testing! ===\033[0m"
