commit-this-feature-branch() {
	main_branch=$1
	feature_branch=$(git rev-parse --abbrev-ref HEAD)
	echo "Rebasing '$feature_branch' on to '$main_branch'"
	git checkout $main_branch
	git fetch
	git pull --rebase
	git checkout $feature_branch
	git fetch
	git rebase $main_branch
	git checkout $main_branch
	git rebase $branch
}

commit-this-feature-branch $1
